import 'package:fluro/fluro.dart';
// import 'package:UnderlordsGuru/app/model/api/APIProvider.dart';
// import 'package:UnderlordsGuru/app/model/api/AppStoreAPIRepository.dart';
import 'package:UnderlordsGuru/app/model/core/AppRoutes.dart';
import 'package:UnderlordsGuru/app/model/db/AppDatabaseMigrationListener.dart';
import 'package:UnderlordsGuru/app/model/db/DBAppStoreRepository.dart';
import 'package:UnderlordsGuru/config/Env.dart';
import 'package:UnderlordsGuru/utility/db/DatabaseHelper.dart';
import 'package:UnderlordsGuru/utility/framework/Application.dart';
import 'package:UnderlordsGuru/utility/log/Log.dart';
import 'package:logging/logging.dart';

class AppStoreApplication implements Application {
  Router router;
  DatabaseHelper _db;
  DBAppStoreRepository dbAppStoreRepository;
  // AppStoreAPIRepository appStoreAPIRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    _initRouter();
    await _initDB();
    _initDBRepository();
  }

  @override
  Future<void> onTerminate() async {
    await _db.close();
  }

  Future<void> _initDB() async {
    AppDatabaseMigrationListener migrationListener =
        AppDatabaseMigrationListener();
    DatabaseConfig databaseConfig = DatabaseConfig(
        Env.value.dbVersion, Env.value.dbName, migrationListener);
    _db = DatabaseHelper(databaseConfig);
    Log.info('DB name : ' + Env.value.dbName);
    // await _db.deleteDB();
    await _db.open();
  }

  void _initDBRepository() {
    dbAppStoreRepository = DBAppStoreRepository(_db.database);
  }

  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.TESTING:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:
        {
          Log.setLevel(Level.ALL);
          break;
        }
      case EnvType.PRODUCTION:
        {
          Log.setLevel(Level.INFO);
          break;
        }
    }
  }

  void _initRouter() {
    router = new Router();
    AppRoutes.configureRoutes(router);
  }
}
