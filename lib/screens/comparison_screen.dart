import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/font_provider.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key});
  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final textController = TextEditingController(text: 'الخط يصنع هويتك | Type makes identity');
  @override
  Widget build(BuildContext context) {
    final p = context.watch<FontProvider>();
    final selected = p.comparedFonts;
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Font Comparison', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('Compare up to three typefaces with exactly the same text.'),
      const SizedBox(height: 16),
      TextField(controller: textController, onChanged: (_) => setState(() {}), decoration: const InputDecoration(labelText: 'Comparison text', prefixIcon: Icon(Icons.edit))),
      const SizedBox(height: 16),
      if (selected.isEmpty) const _EmptyCompare(),
      ...selected.map((font) => Card(margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Expanded(child: Text(font.family, style: const TextStyle(fontWeight: FontWeight.bold))), IconButton(onPressed: () => p.toggleComparison(font.family), icon: const Icon(Icons.close))]),
        Text(textController.text, style: GoogleFonts.getFont(font.family, fontSize: 26)),
        const SizedBox(height: 6),
        Text('${font.category} • ${font.scripts.join(' / ')}', style: Theme.of(context).textTheme.bodySmall),
      ])))),
      const SizedBox(height: 12),
      const Text('Choose typefaces', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      ...p.fonts.map((font) => CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(font.family),
        subtitle: Text(font.category),
        value: p.comparison.contains(font.family),
        onChanged: (_) => p.toggleComparison(font.family),
      )),
      if (selected.length >= 3) const Text('Maximum of three fonts selected.', style: TextStyle(color: Colors.deepOrange)),
    ]);
  }
}

class _EmptyCompare extends StatelessWidget {
  const _EmptyCompare();
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: const [Icon(Icons.compare_arrows, size: 42), SizedBox(height: 8), Text('Select two or more fonts below to compare them.', textAlign: TextAlign.center)])));
}
