import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediease_app/backend%20code/consts.dart';
import 'package:mediease_app/backend%20code/firebase_options.dart';
import 'package:mediease_app/backend%20code/services/user_status.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediEase',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AuthStateListener(),
    );
  }
}