import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:karnama/services/schedule_task_notificaton_service.dart';
import 'package:karnama/view/editTask.dart';
import 'package:karnama/view/screens/selection_theme_screen/bloc/selection_theme_bloc.dart';
import 'package:karnama/view/screens/selection_theme_screen/selection_theme_screen.dart';
import 'package:karnama/view/screens/settings_screen/bloc/settings_bloc.dart';
import 'package:karnama/widgets/AlertDialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 52),
        child: Column(
          children: [
            McwAppBar(
                themeData: themeData, title: appLocalizations.settingsTitle),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(CupertinoIcons.paintbrush_fill),
                  title: Text(appLocalizations.themeSettings),
                  onTap: () async {
                    await Future.delayed(Durations.medium2);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThemeSelectionScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.globe),
                  title: Text(appLocalizations.language),
                  onTap: () async {
                    await Future.delayed(Durations.medium2);
                    var selectedLanguage = await showLanguageDialog(context);
                    if (selectedLanguage == localeFa) {
                      BlocProvider.of<SelectionThemeBloc>(context).add(
                          ChangeThemeEvent(
                              languageCode: selectedLanguage!.languageCode));
                    }
                    if (selectedLanguage == localeEn) {
                      BlocProvider.of<SelectionThemeBloc>(context).add(
                          ChangeThemeEvent(
                              languageCode: selectedLanguage!.languageCode));
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.bell_fill),
                  title: Text(appLocalizations.ringtone),
                  onTap: () async {
                    await Future.delayed(Durations.medium2);
                    var selectedRingtone = await showRingtoneDialog(context);
                    if (selectedRingtone != null) {
                      BlocProvider.of<SettingsBloc>(context).add(
                          ChangeRingtoneNotificatonSettingEvent(
                              ringtone: selectedRingtone));
                    }
                  },
                ),
                ListTile(
                leading: const Icon(CupertinoIcons.doc_text_fill),
                title: Text(appLocalizations.versionName('1.0.0')),
                onTap: () async {},
              )
              ],
            )
          ],
        ),
      ),
    );
  }
}
