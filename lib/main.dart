// lib/main.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/welcome/welcome_page.dart';
import 'features/auth/sign_in.dart';
import 'features/auth/sign_up.dart';
import 'features/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase - replace these values with yours
  await Supabase.initialize(
    url: 'https://oucjrqazmrmlnafitqqy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91Y2pycWF6bXJtbG5hZml0cXF5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc0Mjc2MDMsImV4cCI6MjA3MzAwMzYwM30.fdOSwbzPtdQ7EWU_GQ6LpKJr8p1Q9SkVlMGITNqkqGs',
  );

  runApp(const PharmaScanApp());
}

class PharmaScanApp extends StatelessWidget {
  const PharmaScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    // If there is an active session you may want to skip Welcome/SignIn, but
    // you requested Welcome first -> user will press Get Started.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmaScan',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(), // make sure HomePage exists
      },
    );
  }
}
