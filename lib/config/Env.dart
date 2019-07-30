import 'package:flutter/material.dart';
import 'package:UnderlordsGuru/app/model/core/AppComponent.dart';
import 'package:UnderlordsGuru/app/model/core/AppStoreApplication.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, TESTING }

class Env {
  static Env value;

  String appName;
  String baseUrl;
  Color primarySwatch;
  EnvType environmentType = EnvType.DEVELOPMENT;

  // Database Config
  int dbVersion = 2;
  String dbName;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.STAGING == environmentType) {
      Stetho.initialize();
    }

    await DotEnv().load('.env');

    var application = AppStoreApplication();
    await application.onCreate();

    runApp(AppComponent(application));
  }
}
