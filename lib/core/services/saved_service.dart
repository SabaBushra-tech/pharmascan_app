import 'package:shared_preferences/shared_preferences.dart';

class SavedService {
  static const _key = 'saved_ids';

  Future<List<String>> getSaved() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<bool> isSaved(String id) async {
    final list = await getSaved();
    return list.contains(id);
  }

  Future<void> toggleSaved(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    await prefs.setStringList(_key, list);
  }
}
