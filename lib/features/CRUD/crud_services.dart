import 'dart:convert';

import 'package:clever_tech/constants/crud_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class DataBaseAlreadyOpenException implements Exception {}

class UnableToGetDocumentDirectory implements Exception {}

class DataBaseNotOpen implements Exception {}

class CouldNotDeleteAccount implements Exception {}

class UserAlreadyExists implements Exception {}

class DataBaseService {
  Database? _db;

  Database _getDatabase() {
    final db = _db;
    if (db == null) {
      throw DataBaseNotOpen();
    } else {
      return db;
    }
  }

  Future<void> open() async {
    if (_db != null) {
      throw DataBaseAlreadyOpenException();
    }
    try {
      final docPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

      await db.execute(createUserTable);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentDirectory();
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DataBaseNotOpen();
    } else {
      db.close();
    }
  }

  Future<void> deleteUser({required String email}) async {
    final db = _getDatabase();
    final deleteCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deleteCount != 1) {
      throw CouldNotDeleteAccount();
    }
  }

  Future<DatabaseUser> createUser({required String email}) async {
    final db = _getDatabase();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExists();
    }

    final userId = await db.insert(
      userTable,
      {emailField: email.toLowerCase()},
    );

    final data = DatabaseUser(
      id: userId,
      email: email,
    );

    return data;
  }
}

class DatabaseUser {
  final int id;
  final String email;
  final String? displayName;
  List<Rooms>? rooms;

  DatabaseUser({
    required this.id,
    required this.email,
    this.rooms,
    this.displayName,
  });

  factory DatabaseUser.fromJson(Map<String, dynamic> map) => DatabaseUser(
        id: map[idField].toDouble(),
        email: map[emailField].toString(),
        displayName: map[displayNameField].toString(),
        rooms: List<Rooms>.from(
          map[roomField].map((rooms) => Rooms.fromJson(rooms)),
        ),
      );

  Map<String, dynamic> toJson() => {
        idField: id,
        emailField: email,
        displayNameField: displayName,
        roomField: List<dynamic>.from(rooms!.map((x) => x.toJson)),
      };

  @override
  String toString() =>
      'Person(id: $id, email: $email, displayName: $displayName)';

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Rooms {
  String roomName;
  bool status;
  List<Devices> devices;

  Rooms({
    required this.roomName,
    required this.status,
    required this.devices,
  });

  factory Rooms.fromJson(Map<String, dynamic> rooms) => Rooms(
        roomName: rooms[roomNameField].toString(),
        status: (rooms[roomStatusField].toString() == "true") ? true : false,
        devices: List<Devices>.from(
          rooms[deviceField].map((devices) => Devices.fromJson(devices)),
        ),
      );

  Map<String, dynamic> toJson() => {
        roomNameField: roomName,
        roomStatusField: status,
        deviceField: List<dynamic>.from(devices.map((x) => x.toJson())),
      };
}

enum DeviceType {
  bells,
  camera,
  sockets,
  kettels,
  thermostat,
}

class Devices {
  String deviceName;
  DeviceType deviceType;

  Devices({
    required this.deviceName,
    required this.deviceType,
  });

  factory Devices.fromJson(Map<String, dynamic> devices) => Devices(
        deviceName: devices[deviceNameField].toString(),
        deviceType: devices[deviceTypeField].cast<DeviceType>(),
      );

  Map<String, dynamic> toJson() => {
        deviceNameField: deviceName,
        deviceTypeField: deviceType,
      };
}
