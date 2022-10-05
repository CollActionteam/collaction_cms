import 'package:collaction_admin/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collaction_admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import './infrastructure/core/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureInjection();

  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(const AppWidget());
}
