import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karnama/data/datasource/local_hive_task_data_source_impl.dart';
import 'package:karnama/data/datasource/local_hive_user_setting_data_source_impl.dart';
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/data/repo/user_setting_repository_impl.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/setup/service_locator.dart';
import 'package:karnama/view/bloc/task_bloc.dart';
import 'package:karnama/view/screens/selection_theme_screen/bloc/selection_theme_bloc.dart';
import 'package:provider/provider.dart';

class MyProvider extends StatelessWidget {
  final Widget child;
  const MyProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          Repository<Task>(injectDataSourceImpl: HiveTaskImpl(box: taskbox)),
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => TaskBloc(
              repository:
                  Provider.of<Repository<Task>>(context, listen: false)),
        ),
        BlocProvider(
          create: (context) => SelectionThemeBloc(UserSettingRepository(
              local: LocalHiveUserSettingDataSourceImpl(
                  usersettingBox: UserSettingBox))),
        ),
      ], child: child),
    );
  }
}
