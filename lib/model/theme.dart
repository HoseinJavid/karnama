import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ThemeBase {
  final bool isNew;
  final bool isPremium;
  final MyCustomAppTheme myCustomAppTheme;
  final String themeIdentifer;

  ThemeBase(
      {this.isNew = false,
      this.isPremium = false,
      required this.myCustomAppTheme,
      required this.themeIdentifer});
}

/// Data model for solid color themes.
class SolidColorTheme extends ThemeBase {
  SolidColorTheme(
      {required super.themeIdentifer,
      super.isNew,
      super.isPremium,
      required super.myCustomAppTheme});
}

/// Data model for landscape/wallpaper themes.
class LandscapeTheme extends ThemeBase {
  final String imageUri;

  LandscapeTheme(
      {super.isNew,
      super.isPremium,
      required super.myCustomAppTheme,
      required this.imageUri,
      required super.themeIdentifer});
}

class MyCustomAppTheme {
  final Color surfaceColor;
  final Color primaryColor;
  final Color secendaryColor;
  final Color onPrimaryColor;
  final Color onSecondaryColor;
  final Color onSurfaceColor;
  final Brightness brightness;

  MyCustomAppTheme(
      {required this.surfaceColor,
      required this.primaryColor,
      required this.secendaryColor,
      required this.onPrimaryColor,
      required this.onSecondaryColor,
      required this.onSurfaceColor,
      required this.brightness});
}
