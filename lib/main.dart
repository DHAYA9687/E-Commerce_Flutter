// import 'pages/onboarding.dart';
// ignore_for_file: avoid_print

// import 'package:e_commerce/pages/onboarding.dart';
// import 'package:e_commerce/pages/onboarding.dart';
import 'package:e_commerce/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoarding(),
      routes: {
        '/first': (context) {
          print("home works");
          return const HomePage();
        },
      },
    );
  }
}
