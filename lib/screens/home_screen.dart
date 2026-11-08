import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/font_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/font_card.dart';
import 'preview_screen.dart';
import 'comparison_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final pages = [
      const _LibraryTab(),
      const PreviewScreen(),
      const ComparisonScreen(),
      const FavoritesScreen(),
      const SettingsScreen(),
    ];
    return Directionality(
      textDirection: settings.english ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: IndexedStack(index: index, children: pages)),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) => setState(() => index = value),
          destinations: [
            NavigationDestination(icon: const Icon(Icons.grid_view_rounded), label: settings.english ? 'Library' : 'المكتبة'),
            NavigationDestination(icon: const Icon(Icons.text_fields), label: settings.english ? 'Preview' : 'المعاينة'),
            NavigationDestination(icon: const Icon(Icons.compare), label: settings.english ? 'Compare' : 'مقارنة'),
            NavigationDestination(icon: const Icon(Icons.favorite_border), label: settings.english ? 'Saved' : 'المفضلة'),
            NavigationDestination(icon: const Icon(Icons.tune), label: settings.english ? 'Settings' : 'الإعدادات'),
          ],
        ),
      ),
    );
  }
}

class _LibraryTab extends StatelessWidget {
  const _LibraryTab();

  @override
  Widget build(BuildContext context) {
    final p = context.watch<FontProvider>();
    final en = context.watch<SettingsProvider>().english;
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
        sliver: SliverToBoxAdapter(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(width: 46, height: 46, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.font_download_rounded, color: Colors.white)),
              const SizedBox(width: 12),
              const Text('Fontify', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800)),
              const Spacer(),
              IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComparisonScreen())), icon: const Icon(Icons.compare_arrows_rounded)),
            ]),
            const SizedBox(height: 22),
            Text(en ? 'Find your perfect type' : 'اكتشف الخط الذي يعبّر عنك', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(en ? 'Explore, preview and compare typefaces.' : 'استكشف الخطوط وجرّبها وقارن بينها بسهولة.', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 18),
            TextField(onChanged: p.search, decoration: InputDecoration(hintText: en ? 'Search fonts...' : 'ابحث عن خط...', prefixIcon: const Icon(Icons.search), suffixIcon: p.query.isEmpty ? null : IconButton(onPressed: () => p.search(''), icon: const Icon(Icons.close)))),
            const SizedBox(height: 14),
            _Chips(label: en ? 'Category' : 'التصنيف', values: const ['All', 'Sans Serif', 'Serif', 'Display'], selected: p.category, onSelect: p.filterCategory),
            const SizedBox(height: 8),
            _Chips(label: en ? 'Script' : 'اللغة', values: const ['All', 'Arabic', 'Latin'], selected: p.script, onSelect: p.filterScript),
            const SizedBox(height: 16),
            Row(children: [Text(en ? 'Font collection' : 'مجموعة الخطوط', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), const Spacer(), Text('${p.filteredFonts.length} fonts')]),
          ],
        )),
      ),
      SliverPadding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 20), sliver: SliverList.builder(
        itemCount: p.filteredFonts.length,
        itemBuilder: (context, i) => FontCard(font: p.filteredFonts[i]),
      )),
    ]);
  }
}

class _Chips extends StatelessWidget {
  const _Chips({required this.label, required this.values, required this.selected, required this.onSelect});
  final String label;
  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelect;
  @override
  Widget build(BuildContext context) => Wrap(spacing: 7, crossAxisAlignment: WrapCrossAlignment.center, children: [
    Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
    ...values.map((v) => ChoiceChip(label: Text(v), selected: selected == v, onSelected: (_) => onSelect(v))),
  ]);
}
