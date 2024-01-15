import 'package:flutter/material.dart';
import 'package:flutter_contact_appss/add_form.dart';
import 'package:flutter_contact_appss/home_screen.dart';
import 'package:flutter_contact_appss/splash_screen.dart'; // Import the splash screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set the splash screen as the home
      routes: {
        '/addForm': (context) => AddForm(),
        '/homeScreen': (context) => HomeScreen(),
      },
    );
  }
}
