import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karnama/bloc/task_bloc.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/source/hive_task_impl.dart';
import 'package:karnama/source/repository_injection.dart';
import 'package:karnama/util.dart';
import 'package:karnama/view/screens/splash.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  final box = await Util.initHiveDb<Task>('task');
  runApp(ChangeNotifierProvider(
    create: (context) =>
        Repository<Task>(injectDataSourceImpl: HiveTaskImpl(box: box)),
    child: BlocProvider(
        create: (context) => TaskBloc(
            repository: Provider.of<Repository<Task>>(context, listen: false)),
        child: const Myapp()),
  ));

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    Locale localeSystem = const Locale('fa', 'IR');
    // Locale localeSystem =         const Locale("en", "US");
    // Locale localeSystem = View.of(context).platformDispatcher.locale;
    String iranYekan = 'iranYekan';
    return MaterialApp(
      locale: localeSystem,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      // home: HomeScreen(),
      home: const SplashScreen(),
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
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  fontWeight: FontWeight.w600)),
          datePickerTheme: const DatePickerThemeData()),
    );
  }
}
