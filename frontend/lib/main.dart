import 'package:flutter/material.dart';
import 'screens/admin/admin_login_screen.dart'; // We import the new login screen instead!

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koode App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // This tells the app to open the Login Screen first!
      home: const AdminLoginScreen(), 
    );
  }
}