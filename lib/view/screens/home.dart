import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karnama/constant.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:karnama/view/screens/selection_theme_screen/bloc/selection_theme_bloc.dart';
import 'package:karnama/view/screens/selection_theme_screen/selection_theme_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:karnama/view/bloc/task_bloc.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/view/editTask.dart';
import 'package:karnama/widgets/task.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String querySearch = '';
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(TasksStarted());
  }

  @override
  Widget build(BuildContext context) {
    Repository<Task> repository =
        Provider.of<Repository<Task>>(context, listen: false);
    ThemeData themeData = Theme.of(context);
    AppLocalizations? appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<SelectionThemeBloc, SelectionThemeState>(
      builder: (context, state) {
        return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light),
          child: Scaffold(
            key: scaffoldState,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EdittaskScreen(repository: repository),
                ));
              },
              label: Row(
                children: [
                  Text(appLocalizations!.addNewTask),
                  const SizedBox(width: 8),
                  const Icon(Icons.add_task),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Container(
              decoration: BoxDecoration(
                  image: state is ThemeConfigLoaded
                      ? landscapeThemes[state.themeIdentifer] != null
                          ? DecorationImage(
                              image: AssetImage(
                                  landscapeThemes[state.themeIdentifer]!
                                      .imageUri),
                              fit: BoxFit.cover)
                          : null
                      : null),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: state is ThemeConfigLoaded
                          ? landscapeThemes[state.themeIdentifer] == null
                              ? LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.surface,
                                    Theme.of(context).colorScheme.primary,
                                  ],
                                )
                              : null
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 64, 16, 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  appLocalizations!.toDoList,
                                  style: themeData.textTheme.headlineMedium!
                                      .copyWith(
                                    color: themeData.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    scaffoldState.currentState!.openEndDrawer();
                                    // scaffoldState.currentState!.openDrawer();
                                  },
                                  icon: Icon(
                                    CupertinoIcons.list_bullet,
                                    color: themeData.colorScheme.onPrimary,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // TextField(
                          //   decoration: InputDecoration(
                          //     hintText:
                          //         AppLocalizations.of(context)!.searchTask,
                          //     prefixIcon: const Icon(CupertinoIcons.search),
                          //   ),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       querySearch = value;
                          //     });
                          //     context.read<TaskBloc>().add(TasksSearch(value));
                          //   },
                          // ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<TaskBloc, TaskState>(
                      builder: (context, state) {
                        if (state is TasksLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is TasksError) {
                          return Center(child: Text(state.message));
                        } else if (state is TasksEmpty) {
                          return Center(
                            child: Lottie.asset(
                              'assets/animation/home/defult.json',
                              width: 500,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
                          );
                        } else if (state is TasksSuccess) {
                          List<Task> tasks = state.tasks
                              .where(
                                (task) => task.name
                                    .toLowerCase()
                                    .contains(querySearch.toLowerCase()),
                              )
                              .toList();

                          return CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  height: 3,
                                                  width: 50,
                                                  color: themeData
                                                      .colorScheme.primary,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.black
                                                  .withOpacity(0.05),
                                            ),
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
                                                  if (tasks.isNotEmpty) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            appLocalizations
                                                                .deleteAllTasks,
                                                            style: themeData
                                                                .textTheme
                                                                .titleLarge,
                                                          ),
                                                          content: Text(
                                                            appLocalizations
                                                                .deleteAllTaskCaption,
                                                            style: themeData
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                appLocalizations
                                                                    .no,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        TaskBloc>()
                                                                    .add(
                                                                        TasksDeleteAll());
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                appLocalizations
                                                                    .yes,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 4, 8, 4),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        appLocalizations
                                                            .deleteAll,
                                                        style: TextStyle(
                                                          color: themeData
                                                              .colorScheme
                                                              .onSurface
                                                              .withOpacity(0.3),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                        color: themeData
                                                            .colorScheme
                                                            .onSurface
                                                            .withOpacity(0.3),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 0),
                                      child: TaskItem(
                                        themeData: themeData,
                                        task: tasks[index],
                                        index: index,
                                        repository: repository,
                                      ),
                                    );
                                  },
                                  childCount: tasks.length,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(child: Text('Unknown state'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            endDrawer: const McwDrawer(),
            // drawer: const McwDrawer(),
          ),
        );
      },
    );
  }
}

class McwDrawer extends StatefulWidget {
  const McwDrawer({
    super.key,
  });

  @override
  State<McwDrawer> createState() => _McwDrawerState();
}

class _McwDrawerState extends State<McwDrawer> {
  int _selectedDestination = -1;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<SelectionThemeBloc, SelectionThemeState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: state is ThemeConfigLoaded
                        ? LinearGradient(colors: [
                            findTheme(state.themeIdentifer)
                                .myCustomAppTheme
                                .surfaceColor,
                            findTheme(state.themeIdentifer)
                                .myCustomAppTheme
                                .primaryColor,
                          ])
                        : null),
                // Color(0xffc5b7f3), Color(0xffafe0ee)
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: Text(
                        appLocalizations!.toDoList,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset('assets/img/icon/icon.png')),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(appLocalizations!.supportUs),
                selected: _selectedDestination == 0,
                onTap: () async {
                  await Future.delayed(Durations.medium2);
                  selectDestination(0);
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.all(0),
                      child: RatingDialog(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.format_paint),
                title: Text(appLocalizations.theme),
                selected: _selectedDestination == 1,
                onTap: () async {
                  await Future.delayed(Durations.medium2);
                  Navigator.pop(context);
                  selectDestination(1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThemeSelectionScreen(),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback),
                title: Text(appLocalizations.feedback),
                selected: _selectedDestination == 2,
                onTap: () async {
                  await Future.delayed(Durations.medium2);
                  Navigator.pop(context);
                  selectDestination(2);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(appLocalizations.settings),
                selected: _selectedDestination == 3,
                onTap: () async {
                  await Future.delayed(Durations.medium2);
                  Navigator.pop(context);
                  selectDestination(3);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  appLocalizations!.ratingPromptPrimary,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  appLocalizations.ratingPromptSecondary,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating
                            ? Icons.star_rate_rounded
                            : Icons.star_border_rounded,
                        size: 38,
                        color:
                            index < _rating ? Colors.amber : Colors.grey[700],
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(appLocalizations.buttonLater),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _rating > 0
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    appLocalizations
                                        .ratingThankYouMessage(_rating),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: Text(appLocalizations.buttonRate),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
