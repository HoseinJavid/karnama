import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mdata_base/mdata.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EdittaskScreen extends StatefulWidget {
  final Box<Task> taskBox;
  final int? index;
  const EdittaskScreen({super.key, required this.taskBox, this.index});

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
    textController = TextEditingController(
        text: widget.index != null
            ? widget.taskBox.getAt(widget.index!)!.name
            : null);
    if (widget.index != null) {
      prioritysState[widget.taskBox.getAt(widget.index!)!.priority] = true;
    } else {
      prioritysState[Priority.normal] = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              widget.index != null
                  ? widget.taskBox.getAt(widget.index!)
                  : widget.taskBox.add(Task(
                      name: textController.text, priority: prioritySelected));
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
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          child: Localizations.localeOf(context) ==
                                  const Locale('en')
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
              const SizedBox(
                height: 32,
              ),
              Row(
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
              const SizedBox(
                height: 32,
              ),
              Expanded(
                  child: TextField(
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  hintText: appLocalizations.addATaskForToday,
                ),
                controller: textController,
              ))
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
        width: 118,
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
