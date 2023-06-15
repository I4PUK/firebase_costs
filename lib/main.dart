import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_costs/navigation/app_router.dart';
import 'package:firebase_costs/services/authentication_service.dart';
import 'package:firebase_costs/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'firebase_options.dart';

// это все можно убрать в SL
final router = AppRouter();
String userUid = '';

final databaseService = DatabaseService();
final authService = AuthenticationService(databaseService);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting();

  Intl.defaultLocale = 'ru_RU';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
    );
  }
}
