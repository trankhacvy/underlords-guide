import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database _database;
  DatabaseConfig databaseConfig;

  DatabaseHelper(this.databaseConfig) {
    if (null == databaseConfig) {
      throw NullThrownError;
    }
  }

  Future<void> open() async {
    var path = await _getDBPath();
    // Check if the database exists
    var exists = await databaseExists(path);
    if (!exists) {
      print("Creating new copy from asset");
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        throw new Exception('Cannot create path');
      }

      // Copy from asset
      // AssetBundle rootBundle = DefaultAssetBundle.of(context);
      ByteData data =
          await rootBundle.load(join("assets", databaseConfig.dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // _database = await openDatabase(path,
    //     version: databaseConfig.version,
    //     onCreate: null != databaseConfig.databaseMigrationListener
    //         ? databaseConfig.databaseMigrationListener.onCreate
    //         : null,
    //     onUpgrade: null != databaseConfig.databaseMigrationListener
    //         ? databaseConfig.databaseMigrationListener.onUpgrade
    //         : null);
    _database = await openDatabase(path, readOnly: true);
  }

  Future<void> deleteDB() async {
    var path = await _getDBPath();
    await deleteDatabase(path);
  }

  Future<void> close() async {
    if (null != _database) {
      await _database.close();
    }
  }

  Future<String> _getDBPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, databaseConfig.dbName);
  }

  Database get database => _database;
}

class DatabaseConfig {
  int version;
  String dbName;
  DatabaseMigrationListener databaseMigrationListener;

  DatabaseConfig(this.version, this.dbName, this.databaseMigrationListener);
}

abstract class DatabaseMigrationListener {
  void onCreate(Database db, int version);
  void onUpgrade(Database db, int oldVersion, int newVersion);
}
