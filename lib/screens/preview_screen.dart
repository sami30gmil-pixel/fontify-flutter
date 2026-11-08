import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/font_provider.dart';
import '../providers/settings_provider.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});
  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final controller = TextEditingController(text: 'مرحباً بالعالم | Hello world');
  String family = 'Cairo';
  double size = 30;
  int weight = 500;
  Color foreground = const Color(0xFF29233A);
  Color background = const Color(0xFFF0ECFA);

  @override
  Widget build(BuildContext context) {
    final fonts = context.watch<FontProvider>().fonts;
    final en = context.watch<SettingsProvider>().english;
    if (fonts.isNotEmpty && !fonts.any((f) => f.family == family)) family = fonts.first.family;
    return ListView(padding: const EdgeInsets.all(20), children: [
      Text(en ? 'Preview lab' : 'مختبر المعاينة', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Text(en ? 'Tune your specimen in real time.' : 'اكتب نصك واضبط مظهره وشاهد النتيجة مباشرة.'),
      const SizedBox(height: 18),
      TextField(controller: controller, maxLines: 3, onChanged: (_) => setState(() {}), decoration: InputDecoration(labelText: en ? 'Your text' : 'النص التجريبي')),
      const SizedBox(height: 14),
      DropdownButtonFormField<String>(value: family, decoration: InputDecoration(labelText: en ? 'Typeface' : 'الخط'), items: fonts.map((f) => DropdownMenuItem(value: f.family, child: Text(f.family))).toList(), onChanged: (v) => setState(() => family = v ?? family)),
      const SizedBox(height: 18),
      Card(color: background, child: Padding(padding: const EdgeInsets.all(22), child: Center(child: Text(controller.text, textAlign: TextAlign.center, style: GoogleFonts.getFont(family, fontSize: size, fontWeight: FontWeight.values[(weight ~/ 100 - 1).clamp(0, 8)], color: foreground))))),
      _SliderRow(label: en ? 'Size' : 'الحجم', value: size, min: 12, max: 64, onChanged: (v) => setState(() => size = v)),
      _SliderRow(label: en ? 'Weight' : 'السُمك', value: weight.toDouble(), min: 100, max: 900, divisions: 8, onChanged: (v) => setState(() => weight = v.round())),
      const SizedBox(height: 8),
      Text(en ? 'Text color' : 'لون النص', style: const TextStyle(fontWeight: FontWeight.bold)),
      Wrap(spacing: 10, children: [const Color(0xFF29233A), Colors.black, Colors.deepPurple, Colors.blue, Colors.red, Colors.teal].map((c) => GestureDetector(onTap: () => setState(() => foreground = c), child: CircleAvatar(backgroundColor: c, radius: 15, child: foreground == c ? const Icon(Icons.check, color: Colors.white, size: 16) : null))).toList()),
      const SizedBox(height: 14),
      Text(en ? 'Background' : 'لون الخلفية', style: const TextStyle(fontWeight: FontWeight.bold)),
      Wrap(spacing: 10, children: [const Color(0xFFF0ECFA), Colors.white, const Color(0xFF252331), const Color(0xFFFFF1E6), const Color(0xFFE8F5F0)].map((c) => GestureDetector(onTap: () => setState(() => background = c), child: CircleAvatar(backgroundColor: c, radius: 15, child: background == c ? const Icon(Icons.check, color: Colors.deepPurple, size: 16) : null))).toList()),
    ]);
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({required this.label, required this.value, required this.min, required this.max, required this.onChanged, this.divisions});
  final String label;
  final double value, min, max;
  final int? divisions;
  final ValueChanged<double> onChanged;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Text(label), const Spacer(), Text(value.round().toString())]), Slider(value: value.clamp(min, max), min: min, max: max, divisions: divisions, onChanged: onChanged)]);
}
