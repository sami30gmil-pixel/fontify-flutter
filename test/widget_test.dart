import 'package:flutter_test/flutter_test.dart';
import 'package:fontify/data/repositories/font_repository.dart';

void main() {
  test('catalogue contains curated Arabic and Latin typefaces', () async {
    final fonts = await FontRepository().getFonts();
    expect(fonts, isNotEmpty);
    expect(fonts.any((font) => font.supportsArabic), isTrue);
    expect(fonts.any((font) => font.supportsLatin), isTrue);
  });

  test('font families are unique', () async {
    final fonts = await FontRepository().getFonts();
    expect(fonts.map((font) => font.family).toSet().length, fonts.length);
  });
}
