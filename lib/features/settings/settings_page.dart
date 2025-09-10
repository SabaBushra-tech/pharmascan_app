import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isBn = context.locale.languageCode == 'bn';
    return Scaffold(
      appBar: AppBar(title: Text(tr('settings'))),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(tr('language')),
            subtitle: Text(isBn ? tr('bangla') : tr('english')),
            onTap: () {
              final next = isBn ? const Locale('en') : const Locale('bn');
              context.setLocale(next);
            },
          ),
        ],
      ),
    );
  }
}
