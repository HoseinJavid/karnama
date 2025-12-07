import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/view/bloc/task_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class EdittaskScreen extends StatefulWidget {
  final Repository repository;
  final Task? task;

  const EdittaskScreen({super.key, required this.repository, this.task});

  @override
  State<EdittaskScreen> createState() => _EdittaskScreenState();
}

class _EdittaskScreenState extends State<EdittaskScreen> {
  Jalali? reminderDate;
  TimeOfDay? reminderTime;
  Map<Priority, bool> prioritysState = {
    Priority.high: false,
    Priority.low: false,
    Priority.normal: false
  };
  late TextEditingController titleTaskController;
  late TextEditingController desceriptionTaskController;

  Jalali? _initialReminderDate;
  TimeOfDay? _initialReminderTime;
  late Map<Priority, bool> _initialPrioritysState;
  late String _initialTitle;
  late String _initialDesceription;

  @override
  void initState() {
    //initial
    initialProperty();
    super.initState();
  }

  void initialProperty() {
    if (widget.task != null) {
      titleTaskController = TextEditingController(text: widget.task!.name);
      desceriptionTaskController =
          TextEditingController(text: widget.task!.desceription);

      prioritysState[widget.task!.priority] = true;

      if (widget.task!.reminderDateTime != null) {
        initReminderDateTime();
      }
    } else {
      prioritysState[Priority.normal] = true;
      titleTaskController = TextEditingController();
      desceriptionTaskController = TextEditingController();
    }

    _initialReminderDate = reminderDate;
    _initialReminderTime = reminderTime;
    _initialPrioritysState = Map.from(prioritysState);
    _initialTitle = titleTaskController.text;
    _initialDesceription = desceriptionTaskController.text;
  }

  void initReminderDateTime() {
    //parsing string ISO 8601 to DateTime model
    DateTime parsedDateTime = DateTime.parse(widget.task!.reminderDateTime!);
    //extract jalali
    Jalali recoveredJalali = Jalali.fromDateTime(parsedDateTime);
    //extract TimeOfDay
    TimeOfDay recoveredTime =
        TimeOfDay(hour: recoveredJalali.hour, minute: recoveredJalali.minute);
    reminderDate = recoveredJalali;
    reminderTime = recoveredTime;
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('آیا مطمئن هستید؟'),
            content: const Text('برگردی هرچی تغییر دادی میپره ها! مطمئنی'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('نه'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('آره'),
              ),
            ],
          ),
        )) ??
        false;
  }

  bool hasChanges() {
    if (reminderDate != _initialReminderDate) {
      return true;
    }
    if (reminderTime != _initialReminderTime) {
      return true;
    }

    bool prioritysChanged = false;
    prioritysState.forEach((priority, currentState) {
      if (currentState != _initialPrioritysState[priority]) {
        prioritysChanged = true;
      }
    });
    if (prioritysChanged) {
      return true;
    }

    if (titleTaskController.text != _initialTitle) {
      return true;
    }
    if (desceriptionTaskController.text != _initialDesceription) {
      return true;
    }

    return false;
  }

  Future<void> handleBackPress(BuildContext context) async {
    if (hasChanges()) {
      final bool shouldPop = await _onWillPop(context);
      if (shouldPop) {
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    TaskBloc bloc = BlocProvider.of<TaskBloc>(context);
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    ThemeData themeData = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        await handleBackPress(context);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              doSave(bloc, context, appLocalizations, themeData);
            },
            label: Row(
              children: [
                Text(appLocalizations!.saveChanges),
                const SizedBox(
                  width: 8,
                ),
                const Icon(Icons.check_circle)
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
              top: 52,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                McwAppBar(
                  title: appLocalizations.editTask,
                  themeData: themeData,
                  backPressCallback: handleBackPress,
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: Text(appLocalizations.priorityTitle),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriorityWidget(
                        priority: Priority.high,
                        color: const Color(0xff7465FF),
                        prioritysState: prioritysState,
                        prioritysStateChange: (prioritysState) {
                          setState(() {
                            // this.prioritysState = prioritysState;
                          });
                        },
                        l10nName: appLocalizations.high,
                      ),
                      PriorityWidget(
                        priority: Priority.normal,
                        color: const Color(0xffFC7E2F),
                        prioritysState: prioritysState,
                        prioritysStateChange: (prioritysState) {
                          setState(() {
                            // this.prioritysState = prioritysState;
                          });
                        },
                        l10nName: appLocalizations.normal,
                      ),
                      PriorityWidget(
                        priority: Priority.low,
                        color: const Color(0xff1CC4F6),
                        prioritysState: prioritysState,
                        prioritysStateChange: (prioritysState) {
                          setState(() {
                            // this.prioritysState = prioritysState;
                          });
                        },
                        l10nName: appLocalizations.low,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: TextField(
                    // expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: false,
                        hintText: appLocalizations.addTitleTask,
                        hintStyle: TextStyle(
                            color: themeData.colorScheme.onSurface
                                .withOpacity(0.5))),
                    controller: titleTaskController,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: TextField(
                    // expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: false,
                        hintText: appLocalizations.addDiscriptionTask,
                        hintStyle: TextStyle(
                            color: themeData.colorScheme.onSurface
                                .withOpacity(0.5))),
                    controller: desceriptionTaskController,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 0.1,
                ),
                InkWell(
                  onTap: () async {
                    reminderDate ??= Jalali.now();
                    if (Localizations.localeOf(context).languageCode == 'fa') {
                      reminderDate = await showPersianDatePicker(
                        context: context,
                        initialDate: reminderDate,
                        firstDate: Jalali(1385, 8),
                        lastDate: Jalali(1450, 9),
                        initialEntryMode:
                            PersianDatePickerEntryMode.calendarOnly,
                        // initialDatePickerMode: PersianDatePickerMode.year,
                      );
                    } else {
                      var dateTime = await showDatePicker(
                          context: context,
                          initialDate: reminderDate!.toDateTime(),
                          firstDate: Jalali(1385, 8).toDateTime(),
                          lastDate: Jalali(1450, 9).toDateTime(),
                          initialEntryMode: DatePickerEntryMode.calendarOnly);
                      reminderDate = Jalali.fromDateTime(dateTime!);
                    }
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 64,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24, left: 24),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(
                            width: 8,
                          ),
                          appLocalizations.localeName == 'en'
                              ? Expanded(
                                  child: Text(appLocalizations.reminderDate))
                              : Text(appLocalizations.reminderDate),
                          const Expanded(child: SizedBox()),
                          reminderDate != null
                              ? McwReminderDate(
                                  themeData: themeData,
                                  reminderDate: reminderDate)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 0.1,
                ),
                InkWell(
                  onTap: () async {
                    reminderTime ??= TimeOfDay.now();
                    reminderTime = await showTimePicker(
                      context: context,
                      initialTime: reminderTime!,
                      initialEntryMode: TimePickerEntryMode.input,
                      builder: (BuildContext context, Widget? child) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child!,
                          ),
                        );
                      },
                    );
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 64,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24, left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.timer_outlined),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(appLocalizations.reminderTime),
                          const Expanded(child: SizedBox()),
                          reminderTime != null
                              ? McwReminderTime(
                                  themeData: themeData,
                                  reminderTime: reminderTime)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 0.1,
                ),
                InkWell(
                  onTap: widget.task != null
                      ? () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  appLocalizations.deleteTasks,
                                  style: themeData.textTheme.titleLarge,
                                ),
                                content: Text(
                                  appLocalizations.deleteTaskCaption,
                                  style: themeData.textTheme.bodyLarge,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      appLocalizations.no,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      bloc.add(TasksDelete(widget.task!));
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      appLocalizations.yes,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : null,
                  child: SizedBox(
                    height: 64,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24, left: 24),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outlined,
                            color: widget.task != null
                                ? Colors.red
                                : Colors.grey[400],
                            size: 26,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(appLocalizations.deleteTaskBtm,
                              style: TextStyle(
                                color: widget.task != null
                                    ? Colors.red
                                    : Colors.grey[400],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void doSave(TaskBloc bloc, BuildContext context,
      AppLocalizations appLocalizations, ThemeData themeData) {
    late Priority prioritySelected;
    prioritysState.forEach(
      (key, value) {
        if (value == true) {
          prioritySelected = key;
        }
      },
    );
    if (widget.task != null) {
      bloc.add(TasksUpdate(
          oldTask: widget.task!,
          reminderDate: reminderDate,
          reminderTime: reminderTime,
          prioritySelected: prioritySelected,
          taskName: titleTaskController.text,
          taskDesceription: desceriptionTaskController.text));
      Navigator.of(context).pop();
      FocusScope.of(context).unfocus();
    } else {
      // The code assumes `reminderDate` and `reminderTime` are non-null when entering the 'else if (reminderTime != null)' block.
      // To ensure safety, we use '?' for optional chaining where necessary.
      final String taskTitle = titleTaskController.text.trim();
      if (taskTitle.isEmpty) {
        // Check 1: Empty Title
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(appLocalizations.warningEmptyTitle),
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 3000),
        ));
      } else if (reminderDate != null && reminderTime != null) {
        // Check 2: Reminder is set (Date and Time are available)
        // Create a combined JalaliDateTime object from the selected date and time.
        final Jalali selectedDateTime = Jalali(
          reminderDate!.year,
          reminderDate!.month,
          reminderDate!.day,
          reminderTime!.hour,
          reminderTime!.minute,
        );

        // Check 3: Is the selected time in the past?
        // Jalali.now() includes the current hour and minute, allowing for a single comprehensive check.
        if (selectedDateTime.isBefore(Jalali.now())) {
          // If true, show the past time warning
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              appLocalizations.pastTimeWarning,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(milliseconds: 8000),
          ));
        } else {
          // Valid: Time is in the future
          bloc.add(TasksCreate(
              reminderDate: reminderDate,
              reminderTime: reminderTime,
              taskName: taskTitle,
              prioritySelected: prioritySelected,
              taskDesceription: desceriptionTaskController.text));

          Navigator.of(context).pop();
          FocusScope.of(context).unfocus();

          // Show success message only if a reminder was set (already checked above)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'حله وقتش که رسیدیادت میندازم رفیق',
              style: TextStyle(color: themeData.colorScheme.onPrimary),
            ),
            backgroundColor: themeData.colorScheme.primary,
            duration: const Duration(milliseconds: 3000),
          ));
        }
      } else {
        // Check 4: Reminder is NOT set (reminderTime is null or reminderDate is null)
        // Create task without reminder details
        bloc.add(TasksCreate(
            reminderDate: reminderDate,
            reminderTime: reminderTime,
            taskName: taskTitle,
            prioritySelected: prioritySelected,
            taskDesceription: desceriptionTaskController.text));

        Navigator.of(context).pop();
        FocusScope.of(context).unfocus();

        // Show success message if a reminder was set (though time/date may be null here, the original logic kept this success message outside the reminder check)
        // For tasks without reminders, showing a simple success confirmation is typical.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'حله وقتش که رسیدیادت میندازم رفیق',
            // Assuming this message is acceptable for tasks without reminders too
            style: TextStyle(color: themeData.colorScheme.onPrimary),
          ),
          backgroundColor: themeData.colorScheme.primary,
          duration: const Duration(milliseconds: 3000),
        ));
      }
    }
  }
}

typedef BackPressCallback = Future<void> Function(BuildContext context);

class McwAppBar extends StatelessWidget {
  const McwAppBar(
      {super.key,
      required this.themeData,
      required this.title,
      this.backPressCallback});

  final ThemeData themeData;
  final String title;
  final BackPressCallback? backPressCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              if (backPressCallback != null) {
                await backPressCallback!(context);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Localizations.localeOf(context).languageCode == 'en'
                      ? const Icon(CupertinoIcons.arrow_left)
                      : const Icon(CupertinoIcons.arrow_right)),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: themeData.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

class McwReminderTime extends StatelessWidget {
  const McwReminderTime({
    super.key,
    required this.themeData,
    required this.reminderTime,
  });

  final ThemeData themeData;
  final TimeOfDay? reminderTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: themeData.colorScheme.primary.withAlpha(50)),
      child: Text(reminderTime!.format(context)),
    );
  }
}

class McwReminderDate extends StatelessWidget {
  const McwReminderDate({
    super.key,
    required this.themeData,
    required this.reminderDate,
  });

  final ThemeData themeData;
  final Jalali? reminderDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: themeData.colorScheme.primary.withAlpha(50)),
      child: Text(Localizations.localeOf(context).languageCode == 'fa'
          ? reminderDate!.formatFullDate()
          : DateFormat('EEEE , d MMMM , yyyy')
              .format(reminderDate!.toDateTime())),
    );
  }
}

class PriorityWidget extends StatefulWidget {
  final Color color;
  final Priority priority;
  final Map<Priority, bool> prioritysState;
  final Function(Map<Priority, bool> prioritysState) prioritysStateChange;
  final String l10nName;

  const PriorityWidget(
      {super.key,
      required this.color,
      required this.priority,
      required this.prioritysState,
      required this.prioritysStateChange,
      required this.l10nName});

  @override
  State<PriorityWidget> createState() => _PriorityWidgetState();
}

class _PriorityWidgetState extends State<PriorityWidget> {
  bool checkBox = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          updatePriorityStates();
        });
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 3,
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(
                color: themeData.colorScheme.onSurface.withOpacity(0.15)),
            borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.l10nName,
              ),
              Transform.scale(
                scale: 0.9,
                child: Checkbox(
                  value: widget.prioritysState[widget.priority],
                  onChanged: (value) {
                    setState(() {
                      updatePriorityStates();
                    });
                  },
                  shape: const CircleBorder(),
                  fillColor: WidgetStatePropertyAll(widget.color),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  side: BorderSide.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updatePriorityStates() {
    widget.prioritysState[widget.priority] =
        !widget.prioritysState[widget.priority]!;
    if (Priority.high != widget.priority) {
      widget.prioritysState[Priority.high] = false;
    }
    if (Priority.low != widget.priority) {
      widget.prioritysState[Priority.low] = false;
    }
    if (Priority.normal != widget.priority) {
      widget.prioritysState[Priority.normal] = false;
    }
    widget.prioritysStateChange(widget.prioritysState);
  }
}

class DatePickers extends StatelessWidget {
  const DatePickers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}

class TimePickers extends StatelessWidget {
  const TimePickers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
