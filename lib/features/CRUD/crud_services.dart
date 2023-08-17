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
    final results = db.query(userTable, limit: 1,
        where: 'email = ?',
        whereArgs: [email.toLowerCase()]);
    // if (results.isNotEmpty) {
    //   throw UserAlreadyExists();
    // }

    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase()
    });

    return DatabaseUser(id: userId, email: email);
  }
}

class DatabaseUser {
  final int id;
  final String email;
  final String? displayName;

  const DatabaseUser({
    required this.id,
    required this.email,
    this.displayName,
  });

  DatabaseUser.fromRow(Map<String, dynamic> map)
      : id = map[idColumn] as int,
        email = map[emailColumn] as String,
        displayName = map[displayNameColumn] as String?;

  @override
  String toString() =>
      'Person(id: $id, email: $email, displayName: $displayName)';

  @override
  bool operator ==(covariant DatabaseUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}
