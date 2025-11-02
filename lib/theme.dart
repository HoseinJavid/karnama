import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karnama/constant.dart';
import 'package:karnama/model/theme.dart';


ThemeData getTheme(Locale localeSystem, String iranYekan, BuildContext context,String themeKey) {
  var theme = findTheme(themeKey);
    return ThemeData(
        colorScheme:  ColorScheme.light(
          surface: theme.myCustomAppTheme.surfaceColor, //background
          primary: theme.myCustomAppTheme.primaryColor,
          secondary: theme.myCustomAppTheme.secendaryColor,
          onPrimary: theme.myCustomAppTheme.onPrimaryColor,      //text
          onSecondary: theme.myCustomAppTheme.onSecondaryColor,    //text 
          onSurface: theme.myCustomAppTheme.onSurfaceColor, //text background
        ),
        textTheme: localeSystem == const Locale('fa', 'IR')
            ? TextTheme(
                displayLarge: TextStyle(
                  fontFamily: iranYekan,
                ),
                displayMedium: TextStyle(fontFamily: iranYekan, fontSize: 17),
                displaySmall: TextStyle(fontFamily: iranYekan),
                headlineLarge: TextStyle(fontFamily: iranYekan),
                headlineMedium: TextStyle(
                    fontFamily: iranYekan,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
                headlineSmall: TextStyle(fontFamily: iranYekan),
                titleLarge: TextStyle(fontFamily: iranYekan),
                titleMedium: TextStyle(fontFamily: iranYekan),
                titleSmall: TextStyle(fontFamily: iranYekan),
                bodyLarge: TextStyle(fontFamily: iranYekan),
                bodyMedium: TextStyle(fontFamily: iranYekan, fontSize: 17),
                bodySmall: TextStyle(fontFamily: iranYekan),
                labelLarge: TextStyle(fontFamily: iranYekan),
                labelMedium: TextStyle(fontFamily: iranYekan),
                labelSmall: TextStyle(fontFamily: iranYekan),
              )
            : GoogleFonts.poppinsTextTheme(
                const TextTheme(
                  displayLarge: TextStyle(),
                  displayMedium: TextStyle(fontSize: 17),
                  displaySmall: TextStyle(),
                  headlineLarge: TextStyle(),
                  headlineMedium:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  headlineSmall: TextStyle(),
                  titleLarge: TextStyle(),
                  titleMedium: TextStyle(),
                  titleSmall: TextStyle(),
                  bodyLarge: TextStyle(),
                  bodyMedium: TextStyle(),
                  bodySmall: TextStyle(),
                  labelLarge: TextStyle(),
                  labelMedium: TextStyle(),
                  labelSmall: TextStyle(),
                ),
              ),
        inputDecorationTheme: InputDecorationTheme(
            prefixIconColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                fontWeight: FontWeight.w600)),
        datePickerTheme: const DatePickerThemeData());
  }