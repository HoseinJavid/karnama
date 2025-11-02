import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:karnama/setup/provider.dart';
import 'package:karnama/setup/service_locator.dart';
import 'package:karnama/setup/setup_ui.dart';
import 'package:karnama/view/bloc/task_bloc.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/data/datasource/local_hive_task_data_source_impl.dart';
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/theme.dart';
import 'package:karnama/util.dart';
import 'package:karnama/view/screens/selection_theme_screen/bloc/selection_theme_bloc.dart';
import 'package:karnama/view/screens/splash.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  setupSystemUiConfiguration();

  runApp(const MyProvider(
    child: Myapp(),
  ));
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  void initState() {
    BlocProvider.of<SelectionThemeBloc>(context).add(LoadInitialThemeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale localeSystem = const Locale('fa', 'IR');
    // Locale localeSystem =         const Locale("en", "US");
    // Locale localeSystem = View.of(context).platformDispatcher.locale;
    String iranYekan = 'iranYekan';
    return BlocBuilder<SelectionThemeBloc, SelectionThemeState>(
      builder: (context, state) {
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
          theme: getTheme(
              localeSystem,
              iranYekan,
              context,
              state is ThemeConfigLoaded
                  ? state.themeIdentifer
                  : 'Solid_defult'),
        );
      },
    );
  }
}
