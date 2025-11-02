// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get toDoList => 'To Do List';

  @override
  String get searchTask => 'search task...';

  @override
  String get today => 'Today';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get addNewTask => 'Add new Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get high => 'high';

  @override
  String get normal => 'normal';

  @override
  String get low => 'low';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get deleteAllTasks => 'Delete Tasks';

  @override
  String get deleteAllTaskCaption => 'Do you want to delete all tasks?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get addATaskForToday => 'add a task for today ...';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteTasks => 'Delete Task';

  @override
  String get deleteTaskCaption => 'Do you want to delete task?';

  @override
  String get reminderDate => 'Reminder date';

  @override
  String get reminderTime => 'Reminder time';

  @override
  String get deleteTaskBtm => 'Delete Task';

  @override
  String get textWelcome => 'Welcome to Karnama, buddy!';

  @override
  String get warningEmptyTitle =>
      'Title cannot be empty Please write something';

  @override
  String get supportUs => 'Support us';

  @override
  String get theme => 'Theme';

  @override
  String get faqs => 'FAQs';

  @override
  String get feedback => 'Feedback';

  @override
  String get settings => 'Settings';

  @override
  String get ratingPromptPrimary =>
      'If you enjoy our app, please give us a 5-star rating.';

  @override
  String get ratingPromptSecondary =>
      'We are working hard to provide a better user experience.';

  @override
  String get buttonLater => 'Later';

  @override
  String get buttonRate => 'Rate';

  @override
  String ratingThankYouMessage(int rating) {
    return 'You gave a $rating star rating. Thank you!';
  }
}
