import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nemu_app/main.dart';

Future<void> logoutUser(BuildContext context) async {
  const storage = FlutterSecureStorage();

  await storage.delete(key: 'authToken');

   MyAppWrapper.restartApp(context);

  // Clear navigation stack and go to login
  Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
}
