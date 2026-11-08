import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/font_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsProvider();
  final fonts = FontProvider();
  await settings.load();
  await fonts.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: fonts),
      ],
      child: const FontifyApp(),
    ),
  );
}

class FontifyApp extends StatelessWidget {
  const FontifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) => MaterialApp(
        title: 'Fontify',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
        home: const HomeScreen(),
      ),
    );
  }
}
