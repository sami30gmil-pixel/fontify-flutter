import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/font_provider.dart';
import '../widgets/font_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final fonts = context.watch<FontProvider>().favoriteFonts;
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Favorites', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Text('${fonts.length} saved typefaces'),
      const SizedBox(height: 16),
      if (fonts.isEmpty) const Card(child: Padding(padding: EdgeInsets.all(28), child: Column(children: [Icon(Icons.favorite_border, size: 42), SizedBox(height: 8), Text('Your saved fonts will appear here.')])))
      else ...fonts.map((font) => FontCard(font: font)),
    ]);
  }
}
