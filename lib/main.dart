import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdata_base/controller/taskController.dart';
import 'package:mdata_base/model/model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdata_base/view/screens/home.dart';
import 'package:mdata_base/view/screens/splash.dart';
import 'package:mdata_base/widgets/buttomSheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// String dbTaskName = 'dbTasks';
void main(List<String> args) async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Future.delayed(
  //   Duration(seconds: 2),
  //   () => FlutterNativeSplash.remove(),
  // );
  runApp(const Myapp());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xff6233FF)));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    // Locale localeSystem = View.of(context).platformDispatcher.locale;
    Locale localeSystem = Locale('fa', 'IR');
    // Locale localeSystem = Locale('en','US');
    String iranYekan = 'iranYekan';
    return MaterialApp(
      locale: localeSystem,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // home: HomeScreen(),
      home: SplashScreen(),
      // home: EdittaskScreen(),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Color(0xffF1F5FB),
          primary: Color(0xff6233FF),
          secondary: Color(0xff6233FF),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xff1D2830),
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
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
