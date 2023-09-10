import 'package:app/app/app.dart';
import 'package:app/shared/config/deps.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(appLoader: Deps.init()));
}
