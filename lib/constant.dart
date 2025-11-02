import 'package:flutter/material.dart';
import 'package:karnama/model/theme.dart';
import 'package:mockito/mockito.dart';

// --- SOLID COLOR THEMES ---
final Map<String, SolidColorTheme> solidColorThemes = {
  //algha desimal : 128 - alpah hexadsimal : 80
  'Solid_defult': SolidColorTheme(
      themeIdentifer: 'Solid_defult',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffF1F5FB),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xff6233FF),
          onPrimaryColor: const Color(0xffffffff),
          secendaryColor: const Color(0xff6233FF),
          onSecondaryColor: const Color(0xffffffff),
          brightness: Brightness.light)),

  'Solid_Grey': SolidColorTheme(
      themeIdentifer: 'Solid_Grey',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xff8e8e8e),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: Colors.grey.shade800,
          onPrimaryColor: const Color(0xffffffff),
          secendaryColor: Colors.grey.shade800,
          onSecondaryColor: const Color(0xffffffff),
          brightness: Brightness.light)),
  'Solid_Teal': SolidColorTheme(
      themeIdentifer: 'Solid_Teal',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xff94d6c2),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xFF4CBB99),
          onPrimaryColor: const Color(0xff000000),
          secendaryColor: const Color(0xFF4CBB99),
          onSecondaryColor: const Color(0xff000000),
          brightness: Brightness.light)),
  'Solid_HotPink': SolidColorTheme(
      themeIdentifer: 'Solid_HotPink',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffffa5d2),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xFFFF69B4),
          onPrimaryColor: const Color(0xff000000),
          secendaryColor: const Color(0xFFFF69B4),
          onSecondaryColor: const Color(0xff000000),
          brightness: Brightness.light)),
  'Solid_SlateBlue': SolidColorTheme(
      themeIdentifer: 'Solid_SlateBlue',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffa69ce1),
          onSurfaceColor: Colors.white,
          primaryColor: const Color(0xFF6A5ACD),
          onPrimaryColor: Colors.white,
          secendaryColor: const Color(0xFF6A5ACD),
          onSecondaryColor: Colors.white,
          brightness: Brightness.light)),
  'Solid_DarkOrchid': SolidColorTheme(
      themeIdentifer: 'Solid_DarkOrchid',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffc284e0),
          onSurfaceColor: Colors.white,
          primaryColor: const Color(0xFF9932CC),
          onPrimaryColor: Colors.white,
          secendaryColor: const Color(0xFF9932CC),
          onSecondaryColor: Colors.white,
          brightness: Brightness.light)),
  'Solid_DarkOrange': SolidColorTheme(
      themeIdentifer: 'Solid_DarkOrange',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffffba66),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xFFFF8C00),
          onPrimaryColor: const Color(0xff000000),
          secendaryColor: const Color(0xFFFF8C00),
          onSecondaryColor: const Color(0xff000000),
          brightness: Brightness.light)),
  'Solid_DarkCyan': SolidColorTheme(
      themeIdentifer: 'Solid_DarkCyan',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xff66b3b3),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xFF008080),
          onPrimaryColor: Colors.white,
          secendaryColor: const Color(0xFF008080),
          onSecondaryColor: Colors.white,
          brightness: Brightness.light)),
  'Solid_Gold': SolidColorTheme(
      themeIdentifer: 'Solid_Gold',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffffe766),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xFFFFD700),
          onPrimaryColor: const Color(0xff000000),
          secendaryColor: const Color(0xFFFFD700),
          onSecondaryColor: const Color(0xff000000),
          brightness: Brightness.light)),
  'Solid_Red': SolidColorTheme(
      themeIdentifer: 'Solid_Red',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffe06d6d),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xFFD32F2F),
          onPrimaryColor: Colors.white,
          secendaryColor: const Color(0xFFD32F2F),
          onSecondaryColor: Colors.white,
          brightness: Brightness.light)),
};

// --- LANDSCAPE IMAGE THEMES ---
final Map<String, LandscapeTheme> landscapeThemes = {
  'Landscape_1_Bridge': LandscapeTheme(
    themeIdentifer: 'Landscape_1_Bridge',
    imageUri: 'assets/img/theme/theme-1.jpg',
    myCustomAppTheme: MyCustomAppTheme(
        surfaceColor: const Color(0xff5f6c71),
        onSurfaceColor: const Color(0xffffffff),
        primaryColor: const Color(0xff1a2d34),
        onPrimaryColor: const Color(0xffffffff),
        secendaryColor: const Color(0xff1a2d34),
        onSecondaryColor: const Color(0xffffffff),
        brightness: Brightness.light),
  ),
  'Landscape_2_City': LandscapeTheme(
      themeIdentifer: 'Landscape_2_City',
      imageUri: 'assets/img/theme/theme-2.jpg',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xFFa5a3a0),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xff7f7c77),
          onPrimaryColor: const Color(0xff000000),
          secendaryColor: const Color(0xff7f7c77),
          onSecondaryColor: const Color(0xff000000),
          brightness: Brightness.light)),
  'Landscape_3_Minimal': LandscapeTheme(
      themeIdentifer: 'Landscape_3_Minimal',
      imageUri: 'assets/img/theme/theme-3.jpeg',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xffa0aab6),
          onSurfaceColor: const Color(0xff000000),
          primaryColor: const Color(0xffa0aab6),
          onPrimaryColor: const Color(0xff000000),
          secendaryColor: const Color(0xffa0aab6),
          onSecondaryColor: const Color(0xff000000),
          brightness: Brightness.light)),
  'Landscape_4_Mountain': LandscapeTheme(
      themeIdentifer: 'Landscape_4_Mountain',
      imageUri: 'assets/img/theme/theme-4.jpeg',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xff626e75),
          onSurfaceColor: const Color(0xffffffff),
          primaryColor: const Color(0xff1f303a),
          onPrimaryColor: const Color(0xffffffff),
          secendaryColor: const Color(0xff1f303a),
          onSecondaryColor: const Color(0xffffffff),
          brightness: Brightness.light)),
  'Landscape_5_Sunset': LandscapeTheme(
      themeIdentifer: 'Landscape_5_Sunset',
      imageUri: 'assets/img/theme/theme-5.jpeg',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xff4d565e),
          onSurfaceColor: const Color(0xffffffff),
          primaryColor: const Color(0xff000e19),
          onPrimaryColor: const Color(0xffffffff),
          secendaryColor: const Color(0xff000e19),
          onSecondaryColor: const Color(0xffffffff),
          brightness: Brightness.dark)),
  'Landscape_6_Lake': LandscapeTheme(
      themeIdentifer: 'Landscape_6_Lake',
      imageUri: 'assets/img/theme/theme-6.jpeg',
      myCustomAppTheme: MyCustomAppTheme(
          surfaceColor: const Color(0xfff0cb77),
          onSurfaceColor: const Color(0xff000e19),
          primaryColor: const Color(0xffe9b43d),
          onPrimaryColor: const Color(0xff000e19),
          secendaryColor: const Color(0xffe9b43d),
          onSecondaryColor: const Color(0xff000e19),
          brightness: Brightness.dark)),
};

ThemeBase findTheme(String key) {
  for (var themeKey in landscapeThemes.keys) {
    if (themeKey == key) {
      return landscapeThemes[key]!;
    }
  }
  for (var themeKey in solidColorThemes.keys) {
    if (themeKey == key) {
      return solidColorThemes[key]!;
    }
  }
  throw Exception('theme key is not thrue , or not found');
}

const String keyUserSetting = 'KEY_USER_SETTING';
