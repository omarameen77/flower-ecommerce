class OccasionFallbackImages {
  OccasionFallbackImages._();

  static const String defaultImage =
      'https://images.unsplash.com/photo-1513883049090-d0b7439799bf'
      '?auto=format&fit=crop&w=800&q=80';

  static const Map<String, String> images = {
    'wedding':
        'https://images.unsplash.com/photo-1519741497674-611481863552'
        '?auto=format&fit=crop&w=800&q=80',

    'graduation':
        'https://images.unsplash.com/photo-1523580846011-d3a5bc25702b'
        '?auto=format&fit=crop&w=800&q=80',

    'birthday':
        'https://images.unsplash.com/photo-1530103862676-de8c9debad1d'
        '?auto=format&fit=crop&w=800&q=80',

    'anniversary':
        'https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2'
        '?auto=format&fit=crop&w=800&q=80',

    'new year':
        'https://images.unsplash.com/photo-1514525253161-7a46d19cd819'
        '?auto=format&fit=crop&w=800&q=80',

    'valentines day':
        'https://images.unsplash.com/photo-1512909006721-3d6018887383'
        '?auto=format&fit=crop&w=800&q=80',

    'mothers day':
        'https://images.unsplash.com/photo-1491013516836-7db643ee125a'
        '?auto=format&fit=crop&w=800&q=80',

    'father day':
        'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9'
        '?auto=format&fit=crop&w=800&q=80',

    'christmas':
        'https://images.unsplash.com/photo-1512389142860-9c449e58a543'
        '?auto=format&fit=crop&w=800&q=80',

    'easter':
        'https://images.unsplash.com/photo-1523906630133-f6934a1ab2b9'
        '?auto=format&fit=crop&w=800&q=80',
  };
  static String getImage(String? occasionName) {
    final name = (occasionName ?? '').trim().toLowerCase().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );

    return images[name] ?? defaultImage;
  }
}
