import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mdata_base/editTask.dart';
import 'package:mdata_base/mdata.dart';

class CustomButtomSheet extends StatelessWidget {
  final Box<Task> taskBox;
  final int index;
  const CustomButtomSheet(
      {super.key, required this.index, required this.taskBox});

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
                    builder: (context) => EdittaskScreen(taskBox: taskBox,index: index,),
                  ));
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text('Edit',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          InkWell(
            onTap:() {
              //auto update ui with ValueListenableBuilder
              taskBox.deleteAt(index);
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Future<void> showCustomModalBottomSheet(
      BuildContext context, int index, Box<Task> taskBox) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomButtomSheet(
          index: index,
          taskBox: taskBox,
        );
      },
      useSafeArea: true,
      showDragHandle: true,
    );
  }
}
