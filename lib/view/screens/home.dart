import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:mdata_base/controller/taskController.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mdata_base/view/editTask.dart';
import 'package:mdata_base/widgets/task.dart';

var _initDbResult;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskController controller = TaskController();
  String querySearch = '';
  @override
  void initState() {
    _initDbResult = controller.initHiveDb('dbTasks');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return SafeArea(
        child: FutureBuilder<void>(
      future: _initDbResult,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ); // Loading state
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('error'),
            ),
          ); // Error state
        } else {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EdittaskScreen(controller: controller),
                  )).then((value) => setState(() {
                  }),);
                },
                label: Row(
                  children: [
                    Text(appLocalizations!.addNewTask),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.add_task)
                  ],
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color(0xff7B67FE),
                    Theme.of(context).colorScheme.primary,
                  ])),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(appLocalizations!.toDoList,
                                  style: themeData.textTheme.headlineMedium!
                                      .copyWith(
                                          color:
                                              themeData.colorScheme.onPrimary)),
                            ),
                            Icon(
                              CupertinoIcons.share,
                              color: themeData.colorScheme.onPrimary,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.searchTask,
                            prefixIcon: const Icon(CupertinoIcons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              querySearch = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 4,
                        )
                      ],
                    ),
                  ),
                ),
                //--------------------------------------------------------------------
                Expanded(
                  child: SizedBox(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appLocalizations!.today,
                                          style: themeData
                                              .textTheme.titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          height: 3,
                                          width: 50,
                                          color: themeData.colorScheme.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black.withOpacity(0.05)),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: themeData
                                            .colorScheme.primary
                                            .withOpacity(0.08),
                                        highlightColor: themeData
                                            .colorScheme.primary
                                            .withOpacity(0.08),
                                        onTap: () {
                                          if (controller.isNotEmpty()) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    appLocalizations
                                                        .deleteTasks,
                                                    style: themeData
                                                        .textTheme.titleLarge,
                                                  ),
                                                  content: Text(
                                                    appLocalizations
                                                        .deleteTaskCaption,
                                                    style: themeData
                                                        .textTheme.bodyLarge,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        appLocalizations.no,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        controller
                                                            .deleteAllTask()
                                                            .then(
                                                          (value) {
                                                            setState(() {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        appLocalizations.yes,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 4),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                appLocalizations.deleteAll,
                                                style: TextStyle(
                                                    color: themeData
                                                        .colorScheme.onSurface
                                                        .withOpacity(0.3)),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: themeData
                                                    .colorScheme.onSurface
                                                    .withOpacity(0.3),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        )),
                        controller.isEmpty()
                            ? SliverToBoxAdapter(
                                child: Center(
                                  child: Lottie.asset(
                                      'assets/animation/home/defult.json',
                                      width: 500,
                                      height: 500,
                                      fit: BoxFit.contain),
                                ),
                              )
                            : ValueListenableBuilder(
                                valueListenable: controller.getListanable(),
                                builder: (context, value, child) {
                                  var tempTaskBox = controller
                                      .getValues()
                                      .where(
                                        (element) => element.name
                                            .toLowerCase()
                                            .contains(
                                                querySearch.toLowerCase()),
                                      )
                                      .toList();

                                  return SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                    childCount: tempTaskBox.length,
                                    (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, left: 16),
                                        child: TaskItem(
                                          key: ValueKey(tempTaskBox[index]),
                                          themeData: themeData,
                                          task: tempTaskBox.elementAt(index),
                                          index: index,
                                          controller: controller,
                                        ),
                                      );
                                    },
                                  ));
                                },
                              )
                      ],
                    ),
                  ),
                )
                //--------------------------------------------------------------
                // Expanded(
                //   child: SingleChildScrollView(
                //     physics: BouncingScrollPhysics(),
                //     child: Padding(
                //       padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                //       child: Column(
                //         children: [
                //           Row(
                //             children: [
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       'Today',
                //                       style: themeData.textTheme.titleMedium!
                //                           .copyWith(fontWeight: FontWeight.bold),
                //                     ),
                //                     Container(
                //                       height: 3,
                //                       width: 50,
                //                       color: themeData.colorScheme.primary,
                //                     )
                //                   ],
                //                 ),
                //               ),
                //               Container(
                //                 decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(4),
                //                     color: Colors.black.withOpacity(0.05)),
                //                 child: Padding(
                //                   padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                //                   child: Row(
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Text(
                //                         'Delete All',
                //                         style: TextStyle(
                //                             color: themeData.colorScheme.onSurface
                //                                 .withOpacity(0.3)),
                //                       ),
                //                       const SizedBox(
                //                         width: 4,
                //                       ),
                //                       Icon(
                //                         Icons.delete,
                //                         size: 20,
                //                         color: themeData.colorScheme.onSurface
                //                             .withOpacity(0.3),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //           const SizedBox(
                //             height: 16,
                //           ),
                //           SizedBox(
                //             child: ListView.builder(
                //               shrinkWrap: true,
                //               physics: NeverScrollableScrollPhysics(),
                //               itemCount: tasksBox.length,
                //               itemBuilder: (context, index) {
                //                 return TaskItem(
                //                     themeData: themeData, task: tasksBox.getAt(index)!);
                //               },
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // )
                //-----------------------------------------------------------------------
              ],
            ),
          ); // Success state
        }
      },
    ));
  }
}
