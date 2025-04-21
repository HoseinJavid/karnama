import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/task_bloc.dart';
import 'package:todolist/model/model.dart';
import 'package:todolist/source/repository_injection.dart';
import 'package:todolist/widgets/buttomSheet.dart';

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
                  color: widget.themeData.colorScheme.onPrimary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))]
                  // color: Colors.black,
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
                      setState(() {});
                    },
                  ),
                  Expanded(
                      child: Text(
                    widget.task.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: widget.themeData.textTheme.bodyMedium!.copyWith(
                        height: 2,
                        decoration:
                            widget.task.isCompleted
                                ? TextDecoration.lineThrough
                                : null),
                  )),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onLongPress: () {
                  CustomButtomSheet.showCustomModalBottomSheet(
                      context, widget.task, widget.repository);
                },
                onTap: () {
                  // setState(() {
                  //   ischecked = ! ischecked;
                  update_isComplate_dbTask(bloc);
                  // });
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
    widget.task.isCompleted = !widget.task.isCompleted;
    //update db
    bloc.add(TasksUpdate(widget.task));
    // widget.repository.toggleTask(widget.index, widget.task);
  }
}
