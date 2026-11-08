class FontModel {
  const FontModel({
    required this.family,
    required this.category,
    required this.scripts,
    required this.description,
    required this.weights,
    required this.useCases,
  });

  final String family;
  final String category;
  final List<String> scripts;
  final String description;
  final List<int> weights;
  final List<String> useCases;

  String get sourceUrl =>
      'https://fonts.google.com/specimen/${Uri.encodeComponent(family).replaceAll('%20', '+')}';

  String get license => 'SIL Open Font License (verify family-specific terms)';

  bool get supportsArabic => scripts.contains('Arabic');
  bool get supportsLatin => scripts.contains('Latin');
}
