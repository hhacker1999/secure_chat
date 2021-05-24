import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nigga_chat/app/app_constants.dart';
import 'package:nigga_chat/app/app_router.dart' as router;
import 'package:nigga_chat/app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoutes,
      initialRoute: AppConstants.startUpView,
    );
  }
}
