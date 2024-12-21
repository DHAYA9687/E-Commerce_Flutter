import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/pages/navigationbar.dart';
import 'package:e_commerce/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only if not already initialized
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // ignore: avoid_print
    print('Firebase is already initialized: $e');
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Signup(),
      routes: {
        '/first': (context) => const BottomNav(),
        '/signup': (context) => const Signup(),
        '/login': (context) => const Login(),
      },
    );
  }
}
