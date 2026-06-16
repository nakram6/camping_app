import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/home_screen.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();

await dotenv.load(
fileName: ".env",
);

runApp(const CampingApp());
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
home: const HomeScreen(),
);
}
}
