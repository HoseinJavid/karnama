import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mdata_base/controller/taskController.dart';
import 'package:mdata_base/model/model.dart';
import 'package:mdata_base/view/editTask.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButtomSheet extends StatelessWidget {
  final TaskController controller;
  final int index;
  const CustomButtomSheet(
      {super.key, required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
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
                      controller: controller,
                      index: index,
                    ),
                  ));
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child:  Text(AppLocalizations.of(context)!.edit,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              //auto update ui with ValueListenableBuilder
              controller.deleteTask(index);
              Navigator.of(context).pop();
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child:  Text(
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
      BuildContext context, int index, TaskController controller) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomButtomSheet(
          index: index,
          controller: controller,
        );
      },
      useSafeArea: true,
      showDragHandle: true,
    );
  }
}
