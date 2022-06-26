import 'package:collaction_admin/app_widget.dart';
import 'package:collaction_admin/firebase_options.dart';
import 'package:collaction_admin/infrastructure/core/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureInjection();
  runApp(const AppWidget());
}
