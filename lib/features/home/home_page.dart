import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../scan/scan_page.dart';
import '../search/search_page.dart';
import '../saved/saved_page.dart';
import '../settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final _pages = const [ScanPage(), SearchPage(), SavedPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.qr_code_scanner),
            label: 'scan'.tr(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: 'search'.tr(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.bookmark),
            label: 'saved'.tr(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: 'settings'.tr(),
          ),
        ],
      ),
    );
  }
}
