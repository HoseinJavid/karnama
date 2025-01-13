import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdata_base/editTask.dart';
import 'package:mdata_base/mdata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdata_base/widgets/buttomSheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String dbTaskName = 'dbTasks';
var _initDbResult;
void main(List<String> args) async {
  // await initDb();
  runApp(const Myapp());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xff6233FF)));
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    String iranYekan = 'iranYekan';
    return MaterialApp(
      locale: const Locale('fa'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeScreen(),
      // home: EdittaskScreen(),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Color(0xffF1F5FB),
          primary: Color(0xff6233FF),
          secondary: Color(0xff6233FF),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xff1D2830),
        ),
        textTheme: Locale('en') == const Locale('en')
            ? GoogleFonts.poppinsTextTheme(
                const TextTheme(
                  headlineMedium:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  titleLarge:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              )
            : TextTheme(
                displayLarge: TextStyle(
                  fontFamily: iranYekan,
                ),
                displayMedium: TextStyle(fontFamily: iranYekan, fontSize: 17),
                displaySmall: TextStyle(fontFamily: iranYekan),
                headlineLarge: TextStyle(fontFamily: iranYekan),
                headlineMedium: TextStyle(
                    fontFamily: iranYekan,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
                headlineSmall: TextStyle(fontFamily: iranYekan),
                titleLarge: TextStyle(fontFamily: iranYekan),
                titleMedium: TextStyle(fontFamily: iranYekan),
                titleSmall: TextStyle(fontFamily: iranYekan),
                bodyLarge: TextStyle(fontFamily: iranYekan),
                bodyMedium: TextStyle(
                  fontFamily: iranYekan,
                ),
                bodySmall: TextStyle(fontFamily: iranYekan),
                labelLarge: TextStyle(fontFamily: iranYekan),
                labelMedium: TextStyle(fontFamily: iranYekan),
                labelSmall: TextStyle(fontFamily: iranYekan),
              ),
        inputDecorationTheme: InputDecorationTheme(
            prefixIconColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                fontWeight: FontWeight.w600)),
        // checkboxTheme: CheckboxThemeData(
        //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //     visualDensity: VisualDensity.compact),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String querySearch = '';
  late Box<Task> tasksBox;
  @override
  void initState() {
    _initDbResult = initDb().then(
      (value) => tasksBox = Hive.box<Task>(dbTaskName),
    );
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
                    builder: (context) => EdittaskScreen(taskBox: tasksBox),
                  ));
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
                                          if (tasksBox.isNotEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(appLocalizations
                                                      .deleteTasks),
                                                  content: Text(appLocalizations
                                                      .deleteTaskCaption),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                          appLocalizations.no),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        tasksBox.clear().then(
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
                                                          appLocalizations.yes),
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
                        ValueListenableBuilder(
                          valueListenable: tasksBox.listenable(),
                          builder: (context, value, child) {
                            var tempTaskBox = tasksBox.values
                                .where(
                                  (element) => element.name
                                      .toLowerCase()
                                      .contains(querySearch.toLowerCase()),
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
                                    taskBox: tasksBox,
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

class TaskItem extends StatefulWidget {
  const TaskItem(
      {super.key,
      required this.themeData,
      required this.task,
      required this.index,
      required this.taskBox});

  final ThemeData themeData;
  final Task task;
  final int index;
  final Box<Task> taskBox;

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
                        // backgroundColor:
                        //     widget.taskBox.getAt(widget.index)!.isCompleted
                        //         ? widget.themeData.colorScheme.primary
                        //             .withOpacity(0.05)
                        //         : null,
                        decoration:
                            widget.taskBox.getAt(widget.index)!.isCompleted
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
                      context, widget.index, widget.taskBox);
                },
                onTap: () {
                  // setState(() {
                  //   ischecked = ! ischecked;
                  update_isComplate_dbTask();
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

  void update_isComplate_dbTask() {
    //update auto ui after db
    widget.task.isCompleted = !widget.task.isCompleted;
    //update db
    widget.taskBox.putAt(widget.index, widget.task);
  }
}

Future<void> initDb() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(dbTaskName).then(
    (value) {
      Future.wait([
        value.add(Task(
            name: ' Wake up early (e.g., 6:30 AM)', priority: Priority.high)),
        value
            .add(Task(name: ' Drink a glass of water', priority: Priority.low)),
        value.add(Task(
            name: 'Exercise or stretch (15–30 minutes)',
            priority: Priority.high)),
        value.add(Task(
            name: ' Check and respond to important emails/messages',
            priority: Priority.low,
            isCompleted: true)),
        value.add(Task(
            name:
                'Take a 10-minute break after every 50–60 minutes of focused work',
            priority: Priority.normal)),
        value.add(Task(
            name: ' Read [specific book/article] (e.g., 10–20 pages)',
            priority: Priority.normal,
            isCompleted: true))
      ]).then(
        (value) {
          // runApp(const Myapp());
        },
      );
    },
  );
}
