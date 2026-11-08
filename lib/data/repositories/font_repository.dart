import '../models/font_model.dart';

class FontRepository {
  // Curated families available in Google Fonts. Family metadata is descriptive;
  // check the linked specimen for current variants and license files.
  static const List<FontModel> _fonts = [
    FontModel(family: 'Cairo', category: 'Sans Serif', scripts: ['Arabic', 'Latin'], description: 'A contemporary Arabic sans family suited to interfaces and editorial layouts.', weights: [400, 500, 600, 700, 800], useCases: ['UI design', 'Headings']),
    FontModel(family: 'Tajawal', category: 'Sans Serif', scripts: ['Arabic', 'Latin'], description: 'A clean geometric Arabic typeface with a friendly modern voice.', weights: [300, 400, 500, 700, 800], useCases: ['Apps', 'Content']),
    FontModel(family: 'Amiri', category: 'Serif', scripts: ['Arabic', 'Latin'], description: 'A classical Naskh-inspired serif design for expressive reading.', weights: [400, 700], useCases: ['Books', 'Editorial']),
    FontModel(family: 'Noto Sans Arabic', category: 'Sans Serif', scripts: ['Arabic', 'Latin'], description: 'A versatile sans family designed for broad language coverage.', weights: [400, 500, 600, 700], useCases: ['Multilingual', 'UI design']),
    FontModel(family: 'Almarai', category: 'Sans Serif', scripts: ['Arabic', 'Latin'], description: 'A modern Arabic sans with a balanced, readable texture.', weights: [300, 400, 700, 800], useCases: ['Branding', 'Interfaces']),
    FontModel(family: 'Readex Pro', category: 'Sans Serif', scripts: ['Arabic', 'Latin'], description: 'A contemporary variable-style family for digital experiences.', weights: [400, 500, 600, 700], useCases: ['Technology', 'UI design']),
    FontModel(family: 'Roboto', category: 'Sans Serif', scripts: ['Latin'], description: 'A neutral workhorse sans family for clear digital typography.', weights: [300, 400, 500, 700, 900], useCases: ['Apps', 'Body text']),
    FontModel(family: 'Montserrat', category: 'Sans Serif', scripts: ['Latin'], description: 'A geometric display-friendly sans with strong headline presence.', weights: [400, 500, 600, 700, 800], useCases: ['Branding', 'Headings']),
    FontModel(family: 'Lato', category: 'Sans Serif', scripts: ['Latin'], description: 'A warm humanist sans family for comfortable reading.', weights: [300, 400, 700, 900], useCases: ['Body text', 'Web']),
    FontModel(family: 'Merriweather', category: 'Serif', scripts: ['Latin'], description: 'A sturdy text serif designed for long-form reading.', weights: [300, 400, 700, 900], useCases: ['Editorial', 'Books']),
    FontModel(family: 'Playfair Display', category: 'Serif', scripts: ['Latin'], description: 'A high-contrast display serif for elegant titles.', weights: [400, 500, 600, 700, 800], useCases: ['Luxury', 'Headings']),
    FontModel(family: 'Oswald', category: 'Display', scripts: ['Latin'], description: 'A condensed display sans suited to impactful short headlines.', weights: [400, 500, 600, 700], useCases: ['Posters', 'Headings']),
  ];

  Future<List<FontModel>> getFonts() async => List.unmodifiable(_fonts);
}
