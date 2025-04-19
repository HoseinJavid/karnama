import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mdata_base/bloc/task_bloc.dart';
import 'package:mdata_base/controller/taskController.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mdata_base/model/model.dart';
import 'package:mdata_base/source/repository_injection.dart';
import 'package:mdata_base/view/editTask.dart';
import 'package:mdata_base/widgets/task.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String querySearch = '';

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(TasksStarted());
  }

  @override
  Widget build(BuildContext context) {
    Repository<Task> repository = Provider.of<Repository<Task>>(context, listen: false);
    ThemeData themeData = Theme.of(context);
    AppLocalizations? appLocalizations = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff7B67FE),
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLocalizations!.toDoList,
                            style: themeData.textTheme.headlineMedium!.copyWith(
                              color: themeData.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        Icon(
                          CupertinoIcons.share,
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchTask,
                        prefixIcon: const Icon(CupertinoIcons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          querySearch = value;
                        });
                        context.read<TaskBloc>().add(TasksSearch(value));
                      },
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TasksLoading) {
                    return const Center(child: CircularProgressIndicator());
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
                    List<Task> tasks = state.tasks.where(
                      (task) => task.name.toLowerCase().contains(querySearch.toLowerCase()),
                    ).toList();

                    return CustomScrollView(
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            appLocalizations!.today,
                                            style: themeData.textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            height: 3,
                                            width: 50,
                                            color: themeData.colorScheme.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black.withOpacity(0.05),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: themeData.colorScheme.primary.withOpacity(0.08),
                                          highlightColor: themeData.colorScheme.primary.withOpacity(0.08),
                                          onTap: () {
                                            if (tasks.isNotEmpty) {
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
                                                          context.read<TaskBloc>().add(TasksDeleteAll());
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
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  appLocalizations.deleteAll,
                                                  style: TextStyle(
                                                    color: themeData.colorScheme.onSurface.withOpacity(0.3),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: themeData.colorScheme.onSurface.withOpacity(0.3),
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
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
    );
  }
}