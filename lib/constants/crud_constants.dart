const dbName = 'clever-tech.db';
const userTable = 'user';
const idField = 'id';
const emailField = 'email';
const displayNameField = 'display_name';
const String roomField = "rooms";
const String roomStatusField = "room-status";
const String roomNameField = "room_name";
const String deviceField = "devices";
const String deviceNameField = "device_name";
const String deviceTypeField = "device_type";


const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
	      "id"	INTEGER NOT NULL,
	      "email"	TEXT NOT NULL UNIQUE,
	      "name"	TEXT,
        "user_rooms" LIST,
	      PRIMARY KEY("id" AUTOINCREMENT)
      );
      ''';
