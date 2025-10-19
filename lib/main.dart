import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const Scaffold(
          body: Center(
            child: Text(
              'Home Screen',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      },
    );
  }
}