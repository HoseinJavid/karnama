import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @toDoList.
  ///
  /// In en, this message translates to:
  /// **'To Do List'**
  String get toDoList;

  /// No description provided for @searchTask.
  ///
  /// In en, this message translates to:
  /// **'search task...'**
  String get searchTask;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// No description provided for @addNewTask.
  ///
  /// In en, this message translates to:
  /// **'Add new Task'**
  String get addNewTask;

  /// No description provided for @editTask.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'high'**
  String get high;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'normal'**
  String get normal;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'low'**
  String get low;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @deleteAllTasks.
  ///
  /// In en, this message translates to:
  /// **'Delete Tasks'**
  String get deleteAllTasks;

  /// No description provided for @deleteAllTaskCaption.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete all tasks?'**
  String get deleteAllTaskCaption;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @addTitleTask.
  ///
  /// In en, this message translates to:
  /// **'add a task for today ...'**
  String get addTitleTask;

  /// No description provided for @addDiscriptionTask.
  ///
  /// In en, this message translates to:
  /// **'add a desceription for today ...'**
  String get addDiscriptionTask;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteTasks.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTasks;

  /// No description provided for @deleteTaskCaption.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete task?'**
  String get deleteTaskCaption;

  /// No description provided for @reminderDate.
  ///
  /// In en, this message translates to:
  /// **'Reminder date'**
  String get reminderDate;

  /// No description provided for @reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get reminderTime;

  /// No description provided for @deleteTaskBtm.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTaskBtm;

  /// No description provided for @textWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Karnama, buddy!'**
  String get textWelcome;

  /// No description provided for @warningEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Title cannot be empty Please write something'**
  String get warningEmptyTitle;

  /// Text for a button or link to support the developers.
  ///
  /// In en, this message translates to:
  /// **'Support us'**
  String get supportUs;

  /// Label for the application theme selection.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Title for the Frequently Asked Questions section.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// Label for submitting feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// Title for the application settings page.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Primary prompt text asking the user to rate the app 5 stars.
  ///
  /// In en, this message translates to:
  /// **'If you enjoy our app, please give us a 5-star rating.'**
  String get ratingPromptPrimary;

  /// Secondary prompt text explaining the development effort.
  ///
  /// In en, this message translates to:
  /// **'We are working hard to provide a better user experience.'**
  String get ratingPromptSecondary;

  /// Text for the 'Later' button.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get buttonLater;

  /// Text for the 'Rate' button.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get buttonRate;

  /// Thank you message after rating submission, with a placeholder for the rating number.
  ///
  /// In en, this message translates to:
  /// **'You gave a {rating} star rating. Thank you!'**
  String ratingThankYouMessage(int rating);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @ringtone.
  ///
  /// In en, this message translates to:
  /// **'Ringtone'**
  String get ringtone;

  /// No description provided for @themeSettings.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// No description provided for @solidColor.
  ///
  /// In en, this message translates to:
  /// **'Solid Color'**
  String get solidColor;

  /// No description provided for @scenery.
  ///
  /// In en, this message translates to:
  /// **'Scenery'**
  String get scenery;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'This App'**
  String get appName;

  /// No description provided for @pastTimeWarning.
  ///
  /// In en, this message translates to:
  /// **'Dear friend, this app is for reminding you of tasks you are *going* to do, not what you have *already* done. Please adjust the time slightly forward! We can\'t alert you for \"yesterday\".'**
  String get pastTimeWarning;

  /// No description provided for @ringtoneDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get ringtoneDefault;

  /// No description provided for @ringtoneBell.
  ///
  /// In en, this message translates to:
  /// **'Bell'**
  String get ringtoneBell;

  /// No description provided for @ringtoneChime.
  ///
  /// In en, this message translates to:
  /// **'Chime'**
  String get ringtoneChime;

  /// No description provided for @ringtoneGalaxy.
  ///
  /// In en, this message translates to:
  /// **'Galaxy'**
  String get ringtoneGalaxy;

  /// No description provided for @ringtoneFunny.
  ///
  /// In en, this message translates to:
  /// **'Funny'**
  String get ringtoneFunny;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @faLanguage.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get faLanguage;

  /// No description provided for @enLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get enLanguage;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'select language'**
  String get selectLanguage;

  /// No description provided for @selectRingtone.
  ///
  /// In en, this message translates to:
  /// **'select ringtone'**
  String get selectRingtone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
