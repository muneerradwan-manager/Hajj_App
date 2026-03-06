import 'package:flutter/material.dart';
import 'core/bootstrap/app_bootstrap.dart';
import 'core/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrapApp();
  runApp(const App());
}
