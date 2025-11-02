import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karnama/view/bloc/task_bloc.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/view/editTask.dart';

class CustomButtomSheet extends StatelessWidget {
  final Repository repository;
  final Task task;
  const CustomButtomSheet(
      {super.key, required this.task, required this.repository});

  @override
  Widget build(BuildContext context) {
    TaskBloc bloc = BlocProvider.of<TaskBloc>(context);
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Future.delayed(
                const Duration(milliseconds: 250),
                () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EdittaskScreen(
                      repository: repository,
                      task: task,
                    ),
                  ));
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(AppLocalizations.of(context)!.edit,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              //auto update ui with ValueListenableBuilder
              // repository.delete(task);
              bloc.add(TasksDelete(task));
              Navigator.of(context).pop();
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  AppLocalizations.of(context)!.delete,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Future<void> showCustomModalBottomSheet(
      BuildContext context, Task task, Repository repository) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomButtomSheet(
          task: task,
          repository: repository,
        );
      },
      useSafeArea: true,
      showDragHandle: true,
    );
  }
}
