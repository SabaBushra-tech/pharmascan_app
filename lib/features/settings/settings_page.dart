import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isBangla = false;

  @override
  void initState() {
    super.initState();
    loadLanguagePreference();
  }

  // Load saved language preference
  Future<void> loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBangla = prefs.getBool('isBangla') ?? false;
    });
  }

  // Save language preference
  Future<void> saveLanguagePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBangla', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Language'),
              subtitle: Text(isBangla ? 'বাংলা' : 'English'),
              trailing: Switch(
                value: isBangla,
                onChanged: (value) {
                  setState(() {
                    isBangla = value;
                  });
                  saveLanguagePreference(value);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value
                            ? 'Language switched to Bangla'
                            : 'Language switched to English',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Add other settings options here
          ],
        ),
      ),
    );
  }
}
