import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/font_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsProvider>();
    final p = context.watch<FontProvider>();
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Settings', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      Card(child: Column(children: [
        SwitchListTile(title: const Text('Dark appearance'), subtitle: const Text('Use the dark color scheme'), value: s.darkMode, onChanged: s.setDarkMode),
        const Divider(height: 1),
        SwitchListTile(title: const Text('English language'), subtitle: const Text('Turn off to use Arabic labels and RTL layout'), value: s.english, onChanged: s.setEnglish),
      ])),
      const SizedBox(height: 16),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Preview text size', style: TextStyle(fontWeight: FontWeight.bold)),
        Slider(value: s.previewSize, min: 16, max: 48, divisions: 16, label: s.previewSize.round().toString(), onChanged: s.setPreviewSize),
      ]))),
      const SizedBox(height: 16),
      Card(child: ListTile(leading: const Icon(Icons.favorite), title: const Text('Saved fonts'), trailing: Text(p.favorites.length.toString()))),
      const Card(child: ListTile(leading: Icon(Icons.info_outline), title: Text('About Fontify'), subtitle: Text('A smart library for Arabic and Latin typography.'))),
      const SizedBox(height: 12),
      const Text('Font metadata is curated for this release. Preview files are provided by Google Fonts and may require an internet connection. Review each family’s official license before using or redistributing font files.', style: TextStyle(fontSize: 12)),
    ]);
  }
}
