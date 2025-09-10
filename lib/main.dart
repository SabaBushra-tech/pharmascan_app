import 'package:flutter/material.dart';

// Import your pages
import 'features/welcome/welcome_page.dart';
import 'features/auth/sign_in.dart';
import 'features/auth/sign_up.dart';
// Import other pages if needed, e.g., scan, saved, search, settings

void main() {
  runApp(const PharmaScanApp());
}

class PharmaScanApp extends StatelessWidget {
  const PharmaScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmaScan',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const WelcomePage(),
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        // Add your other pages here
        // '/scan': (context) => const ScanPage(),
        // '/saved': (context) => const SavedPage(),
        // '/search': (context) => const SearchPage(),
        // '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
