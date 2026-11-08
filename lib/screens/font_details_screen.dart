import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/models/font_model.dart';
import '../providers/font_provider.dart';

class FontDetailsScreen extends StatelessWidget {
  const FontDetailsScreen({super.key, required this.font});
  final FontModel font;

  @override
  Widget build(BuildContext context) {
    final saved = context.watch<FontProvider>().favorites.contains(font.family);
    return Scaffold(
      appBar: AppBar(title: Text(font.family), actions: [
        IconButton(onPressed: () => context.read<FontProvider>().toggleFavorite(font.family), icon: Icon(saved ? Icons.favorite : Icons.favorite_border)),
      ]),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text(font.family, style: GoogleFonts.getFont(font.family, fontSize: 36, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(font.description, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 22),
        _Section(title: 'Arabic specimen', child: Text('الخط العربي الجميل يصنع فرقاً في كل تصميم', style: GoogleFonts.getFont(font.family, fontSize: 27))),
        _Section(title: 'Latin specimen', child: Text('Typography is the art of arranging type.', style: GoogleFonts.getFont(font.family, fontSize: 24))),
        _Section(title: 'Details', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _Info('Category', font.category), _Info('Scripts', font.scripts.join(', ')),
          _Info('Available weights', font.weights.join(', ')),
          _Info('Suggested use', font.useCases.join(', ')),
          _Info('License', font.license),
        ])),
        FilledButton.icon(onPressed: () async {
          final uri = Uri.parse(font.sourceUrl);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication) && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open font source.')));
          }
        }, icon: const Icon(Icons.open_in_new), label: const Text('Open official Google Fonts source')),
        const SizedBox(height: 10),
        Text('Font preview is loaded through Google Fonts. Internet access may be required on first use. Verify the individual family license before redistribution.', style: Theme.of(context).textTheme.bodySmall),
      ]),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 14), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 12), child])));
}
class _Info extends StatelessWidget {
  const _Info(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 130, child: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))), Expanded(child: Text(value))]));
}
