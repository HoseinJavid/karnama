import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:karnama/bloc/task_bloc.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/source/repository_injection.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class EdittaskScreen extends StatefulWidget {
  final Repository repository;
  final Task? task;

  const EdittaskScreen({super.key, required this.repository, this.task});

  @override
  State<EdittaskScreen> createState() => _EdittaskScreenState();
}

class _EdittaskScreenState extends State<EdittaskScreen> {
  Map<Priority, bool> prioritysState = {
    Priority.high: false,
    Priority.low: false,
    Priority.normal: false
  };
  var textController;

  @override
  void initState() {
    textController = TextEditingController(text: widget.task?.name);
    if (widget.task != null) {
      prioritysState[widget.task!.priority] = true;
    } else {
      prioritysState[Priority.normal] = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskBloc bloc = BlocProvider.of<TaskBloc>(context);
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              late Priority prioritySelected;
              prioritysState.forEach(
                (key, value) {
                  if (value == true) {
                    prioritySelected = key;
                  }
                },
              );
              if (widget.task != null) {
                widget.task!.name = textController.text;
                widget.task!.priority = prioritySelected;
                bloc.add(TasksUpdate(widget.task!));
              } else {
                bloc.add(TasksCreate(Task(
                    name: textController.text, priority: prioritySelected)));
              }
              Navigator.of(context).pop();
              FocusScope.of(context).unfocus();
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
        body: Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
            top: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child:
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? const Icon(CupertinoIcons.arrow_left)
                                    : const Icon(CupertinoIcons.arrow_right)),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      appLocalizations.editTask,
                      style: themeData.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
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
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: TextField(
                  // expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintText: appLocalizations.addATaskForToday,
                  ),
                  controller: textController,
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
                  Jalali? picked = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali(1385, 8),
                    lastDate: Jalali(1450, 9),
                    initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
                    // initialDatePickerMode: PersianDatePickerMode.year,
                  );
                },
                child: SizedBox(
                  height: 64,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(right: 24, left: 24),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: 8,
                        ),
                        Text(appLocalizations.dueDate),
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
                  var picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
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
                },
                child: SizedBox(
                  height: 64,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(right: 24, left: 24),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text(appLocalizations.dueTime)
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
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: Localizations.localeOf(context) == const Locale('fa')
              ? const EdgeInsets.only(right: 16)
              : const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.l10nName,
              ),
              Transform.scale(
                scale: 0.65,
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
