const dbName = 'clever-tech.db';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const displayNameColumn = 'name';

const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
	      "id"	INTEGER NOT NULL,
	      "email"	TEXT NOT NULL UNIQUE,
	      "name"	TEXT,
	      PRIMARY KEY("id" AUTOINCREMENT)
      );
      ''';