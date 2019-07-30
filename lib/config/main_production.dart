import 'package:UnderlordsGuru/config/Env.dart';
import 'package:flutter/material.dart';

void main() => Production();

class Production extends Env {
  final String appName = "Underlords Guru";

  final String baseUrl = 'https://api.website.org';
  final Color primarySwatch = Colors.teal;
  EnvType environmentType = EnvType.PRODUCTION;

  final String dbName = 'underlords.sqlite3';
}
