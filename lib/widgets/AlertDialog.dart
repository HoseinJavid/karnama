import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/util.dart';
import 'package:karnama/view/screens/selection_theme_screen/bloc/selection_theme_bloc.dart';

// enum Language { fa, en }
Locale localeFa = const Locale('fa', 'IR');
Locale localeEn = const Locale('en', 'US');

Future<Locale?> showLanguageDialog(BuildContext context) async {
  Locale? selectedLanguage = Localizations.localeOf(context);

  return showDialog<Locale>(
    context: context,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return StatefulBuilder(
        builder: (context, setState) {
          AppLocalizations? appLocalizations = AppLocalizations.of(context);
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      appLocalizations!.selectLanguage,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RadioListTile<Locale>(
                    title: Text(appLocalizations!.faLanguage),
                    value: localeFa,
                    groupValue: selectedLanguage,
                    onChanged: (Locale? value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                    },
                  ),
                  RadioListTile<Locale>(
                    title: Text(appLocalizations!.enLanguage),
                    value: localeEn,
                    groupValue: selectedLanguage,
                    onChanged: (Locale? value) {
                      setState(() {
                        selectedLanguage = value;
                      });
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          },
                          child: Text(appLocalizations!.cancel),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(selectedLanguage);
                          },
                          child: Text(appLocalizations.confirm),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<Ringtone?> showRingtoneDialog(BuildContext context) async {
  UserSetting? userSetting = await BlocProvider.of<SelectionThemeBloc>(context)
      .userSettingRepo
      .getUserSetting();
  ;

  return showDialog<Ringtone>(
    context: context,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      Ringtone? selectedRingtone = userSetting!.selectedRingtone;

      return StatefulBuilder(
        builder: (context, setState) {
          AppLocalizations? appLocalizations = AppLocalizations.of(context);
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      appLocalizations!.selectRingtone,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RadioListTile<Ringtone>(
                    title: Text(appLocalizations.ringtoneDefault),
                    value: Ringtone.defaultalarm,
                    groupValue: selectedRingtone,
                    onChanged: (Ringtone? value) {
                      setState(() {
                        selectedRingtone = value;
                      });
                      playRawFile(value!.name);
                    },
                  ),
                  RadioListTile<Ringtone>(
                    title: Text(appLocalizations.ringtoneChime),
                    value: Ringtone.chimealarm,
                    groupValue: selectedRingtone,
                    onChanged: (Ringtone? value) {
                      setState(() {
                        selectedRingtone = value;
                      });
                      playRawFile(value!.name);
                    },
                  ),
                  RadioListTile<Ringtone>(
                    title: Text(appLocalizations.ringtoneGalaxy),
                    value: Ringtone.galaxyalarm,
                    groupValue: selectedRingtone,
                    onChanged: (Ringtone? value) {
                      setState(() {
                        selectedRingtone = value;
                      });
                      playRawFile(value!.name);
                    },
                  ),
                  RadioListTile<Ringtone>(
                    title: Text(appLocalizations.ringtoneFunny),
                    value: Ringtone.funnyalarm,
                    groupValue: selectedRingtone,
                    onChanged: (Ringtone? value) {
                      setState(() {
                        selectedRingtone = value;
                      });
                      playRawFile(value!.name);
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(null);
                            stopPlayer();

                          },
                          child: Text(appLocalizations.cancel),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(selectedRingtone);
                            stopPlayer();
                          },
                          child: Text(appLocalizations.confirm),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
