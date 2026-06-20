import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'database/hive_init.dart';

import 'screens/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth/auth_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions
            .currentPlatform,
  );

  await dotenv.load(
    fileName: ".env",
  );

  await HiveInit.initialize();

  runApp(
    const CampingApp(),
  );
}

class CampingApp extends StatelessWidget {
const CampingApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Camping Companion',
theme: ThemeData(
colorSchemeSeed: Colors.green,
useMaterial3: true,
),
home: const AuthWrapper(),
);
}
}
