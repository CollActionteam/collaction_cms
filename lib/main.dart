import 'package:collaction_admin/app_widget.dart';
import 'package:collaction_admin/infrastructure/core/firebase_injectable.dart';
import 'package:collaction_admin/presentation/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collaction_admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import './infrastructure/core/injection.dart';
import 'presentation/go_routing/go_routing.dart';
import './presentation/theme/constants.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureInjection(); 

  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

  runApp(AppWidget());

}




