import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/font_model.dart';
import '../data/repositories/font_repository.dart';

class FontProvider extends ChangeNotifier {
  final FontRepository _repository = FontRepository();
  List<FontModel> fonts = [];
  final Set<String> favorites = {};
  final Set<String> comparison = {};
  String query = '';
  String category = 'All';
  String script = 'All';

  Future<void> load() async {
    fonts = await _repository.getFonts();
    final prefs = await SharedPreferences.getInstance();
    favorites.addAll(prefs.getStringList('favorites') ?? []);
    notifyListeners();
  }

  List<FontModel> get filteredFonts => fonts.where((font) {
    final matchesQuery = font.family.toLowerCase().contains(query.toLowerCase());
    final matchesCategory = category == 'All' || font.category == category;
    final matchesScript = script == 'All' || font.scripts.contains(script);
    return matchesQuery && matchesCategory && matchesScript;
  }).toList();

  List<FontModel> get favoriteFonts =>
      fonts.where((font) => favorites.contains(font.family)).toList();

  List<FontModel> get comparedFonts =>
      fonts.where((font) => comparison.contains(font.family)).toList();

  void search(String value) { query = value; notifyListeners(); }
  void filterCategory(String value) { category = value; notifyListeners(); }
  void filterScript(String value) { script = value; notifyListeners(); }

  Future<void> toggleFavorite(String family) async {
    if (!favorites.add(family)) favorites.remove(family);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites.toList());
    notifyListeners();
  }

  void toggleComparison(String family) {
    if (!comparison.add(family)) {
      comparison.remove(family);
    } else if (comparison.length > 3) {
      comparison.remove(comparison.first);
    }
    notifyListeners();
  }
}
