import 'app_widget.dart';
import 'generate_firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'infrastructure/core/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'env');

  await Firebase.initializeApp(
    options: FirebaseOptionsFactory.currentPlatform,
  );

  configureInjection();

  runApp(const AppWidget());
}
