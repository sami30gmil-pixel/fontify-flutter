import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool darkMode = false;
  bool english = false;
  double previewSize = 28;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool('darkMode') ?? false;
    english = prefs.getBool('english') ?? false;
    previewSize = prefs.getDouble('previewSize') ?? 28;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode = value;
    final p = await SharedPreferences.getInstance();
    await p.setBool('darkMode', value);
    notifyListeners();
  }

  Future<void> setEnglish(bool value) async {
    english = value;
    final p = await SharedPreferences.getInstance();
    await p.setBool('english', value);
    notifyListeners();
  }

  Future<void> setPreviewSize(double value) async {
    previewSize = value;
    final p = await SharedPreferences.getInstance();
    await p.setDouble('previewSize', value);
    notifyListeners();
  }
}
