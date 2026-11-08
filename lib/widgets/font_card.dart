import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/models/font_model.dart';
import '../providers/font_provider.dart';
import '../screens/font_details_screen.dart';

class FontCard extends StatelessWidget {
  const FontCard({super.key, required this.font});
  final FontModel font;

  @override
  Widget build(BuildContext context) {
    final p = context.watch<FontProvider>();
    final saved = p.favorites.contains(font.family);
    final compared = p.comparison.contains(font.family);
    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FontDetailsScreen(font: font))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(font.family, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
              IconButton(tooltip: 'Compare', onPressed: () => p.toggleComparison(font.family), icon: Icon(compared ? Icons.check_circle : Icons.add_circle_outline, color: compared ? Theme.of(context).colorScheme.primary : null)),
              IconButton(tooltip: 'Favorite', onPressed: () => p.toggleFavorite(font.family), icon: Icon(saved ? Icons.favorite : Icons.favorite_border, color: saved ? Colors.pink : null)),
            ]),
            Text(font.family == 'Cairo' || font.supportsArabic ? 'مرحباً بالعالم • تصميم أجمل يبدأ بخط' : 'The quick brown fox jumps over the lazy dog',
              textAlign: TextAlign.start,
              style: GoogleFonts.getFont(font.family, fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Wrap(spacing: 6, children: [
              _Tag(font.category),
              ...font.scripts.map(_Tag.new),
              _Tag('${font.weights.length} weights'),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Chip(label: Text(text, style: const TextStyle(fontSize: 11)), visualDensity: VisualDensity.compact, padding: EdgeInsets.zero);
}
