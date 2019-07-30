import 'package:UnderlordsGuru/config/Env.dart';
import 'package:flutter/material.dart';

void main() => Development();

class Development extends Env {
  final String appName = "Underlords Guru Dev";
  final String baseUrl = 'https://api.dev.website.org';
  final Color primarySwatch = Colors.pink;
  EnvType environmentType = EnvType.DEVELOPMENT;

  final String dbName = 'underlords.sqlite3';
}
