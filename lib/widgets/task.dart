import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karnama/util.dart';
import 'package:karnama/view/bloc/task_bloc.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/view/editTask.dart';
import 'package:karnama/widgets/buttomSheet.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key,
      required this.themeData,
      required this.task,
      required this.index,
      required this.repository});

  final ThemeData themeData;
  final Task task;
  final int index;
  final Repository<Task> repository;
  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Map<Priority, Color> priorityColor = {
    Priority.high: const Color(0xff7465FF),
    Priority.normal: const Color(0xffFC7E2F),
    Priority.low: const Color(0xff1CC4F6)
  };
  bool ischecked = false;
  // bool checkBox = true;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TaskBloc>(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            //priority task
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: widget.task.priority == Priority.high
                    ? priorityColor[Priority.high]
                    : widget.task.priority == Priority.normal
                        ? priorityColor[Priority.normal]
                        : widget.task.priority == Priority.low
                            ? priorityColor[Priority.low]
                            : null,
              ),
              height: 65,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                  )
                ],
              ),
              height: 65,
              width: MediaQuery.sizeOf(context).width - 32 - 8,
              child: Row(
                children: [
                  Checkbox(
                    shape: const CircleBorder(),
                    side: BorderSide(
                        color: Colors.black.withOpacity(0.10), width: 2),
                    value: widget.task.isCompleted,
                    onChanged: (value) {
                      update_isComplate_dbTask(bloc);
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stack(
                      // children: [
                      Text(
                        widget.task.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: widget.themeData.textTheme.bodyMedium!.copyWith(
                          height: 2,
                          color: Colors.black,
                          decoration: widget.task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: Theme.of(context).primaryColor,
                          decorationThickness: 3,
                        ),
                      ),
                      widget.task.reminderDateTime != null
                          ? Row(
                              children: [
                                Icon(
                                  CupertinoIcons.bell,
                                  size: 16,
                                  color: Colors.black.withAlpha(120),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  formatDateTime(
                                      widget.task.reminderDateTime!, context),
                                  style: widget.themeData.textTheme.bodySmall!
                                      .copyWith(
                                    color: Colors.black.withAlpha(120),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
            Positioned.fill(
                right: 50,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onLongPress: () {
                      CustomButtomSheet.showCustomModalBottomSheet(
                          context, widget.task, widget.repository);
                    },
                    onTap: () {
                      // update_isComplate_dbTask(bloc);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EdittaskScreen(repository: widget.repository,task: widget.task,),
                      ));
                    },
                    splashColor:
                        widget.themeData.colorScheme.primary.withOpacity(0.08),
                    highlightColor:
                        widget.themeData.colorScheme.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(5),
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  void update_isComplate_dbTask(Bloc bloc) {
    //update auto ui after db
    // widget.task.isCompleted = !widget.task.isCompleted;
    //update db
    bloc.add(TasksUpdate(
        oldTask: widget.task,
        reminderDate: null,
        reminderTime: null,
        prioritySelected: widget.task.priority,
        taskName: widget.task.name,
        isCompleted: !widget.task.isCompleted,
        taskDesceription: widget.task.desceription!));
    // widget.repository.toggleTask(widget.index, widget.task);
  }
}
