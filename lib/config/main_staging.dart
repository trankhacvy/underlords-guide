import 'package:UnderlordsGuru/config/Env.dart';
import 'package:flutter/material.dart';

void main() => Staging();

class Staging extends Env {
  final String appName = "Underlords Guru Staging";

  final String baseUrl = 'https://api.staging.website.org';
  final Color primarySwatch = Colors.amber;
  EnvType environmentType = EnvType.STAGING;

  final String dbName = 'flutterStarter-Stg.db';
}
