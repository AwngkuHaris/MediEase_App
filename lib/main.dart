import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediease_app/backend%20code/consts.dart';
import 'package:mediease_app/backend%20code/firebase_options.dart';
import 'package:mediease_app/backend%20code/services/user_status.dart';
import 'package:mediease_app/frontend%20code/pages/signin%20&%20signup/signin_page.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyANjDYCQMFriTVmnl-uhJ68WGPZArW9PO4",
            authDomain: "medieaseapp.firebaseapp.com",
            projectId: "medieaseapp",
            storageBucket: "medieaseapp.firebasestorage.app",
            messagingSenderId: "718442296538",
            appId: "1:718442296538:web:4bd970a00cacc569a6e1e3"));
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

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
      // home: const AuthStateListener(), -- Original Line
      home: const Scaffold(
        body: Center(
          child: Text(
            'Reminder: Please confirm your appointment before the scheduled time.',
          ),
        ),
      ),
    );
  }
}
