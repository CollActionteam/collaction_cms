import 'package:collaction_cms/app_widget.dart';
import 'package:collaction_cms/generate_firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import './infrastructure/core/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "env");

  await Firebase.initializeApp(
    options: FirebaseOptionsFactory.currentPlatform,
  );

  configureInjection();

  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(const AppWidget());
}
