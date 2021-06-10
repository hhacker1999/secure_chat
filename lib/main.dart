import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nigga_chat/app/app_constants.dart';
import 'package:nigga_chat/app/app_router.dart' as router;
import 'package:nigga_chat/app/locator.dart';
import 'package:sizerutil/sizerutil.dart';

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
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      onGenerateRoute: router.generateRoutes,
      initialRoute: AppConstants.startUpView,
    );
  }
}
