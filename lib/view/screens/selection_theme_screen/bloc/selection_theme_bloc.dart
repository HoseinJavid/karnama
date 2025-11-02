import 'package:bloc/bloc.dart';
import 'package:karnama/constant.dart';
import 'package:karnama/data/repo/user_setting_repository_impl.dart';
import 'package:karnama/model/model.dart';
import 'package:meta/meta.dart';

part 'selection_theme_event.dart';
part 'selection_theme_state.dart';

class SelectionThemeBloc
    extends Bloc<SelectionThemeEvent, SelectionThemeState> {
  final UserSettingRepository userSettingRepo;
  SelectionThemeBloc(this.userSettingRepo) : super(SelectionThemeInitial()) {
    on<SelectionThemeEvent>((event, emit) async {
      if (event is LoadInitialThemeEvent) {
        var setting = await userSettingRepo.getUserSetting();
        if (setting == null) {
          await userSettingRepo
              .initialUserSetting(UserSetting(themeIdentifer: 'Solid_defult'));
          emit(ThemeConfigLoaded(themeIdentifer: 'Solid_defult'));
        } else {
          var themeId = setting.themeIdentifer;
          emit(ThemeConfigLoaded(themeIdentifer: themeId));
        }
      }
      if (event is ChangeThemeEvent) {
        var setting = await userSettingRepo.getUserSetting();
        setting!.themeIdentifer = event.themeIdentifer;
        userSettingRepo.updateThemeUserSetting(setting);
        var themeId = setting.themeIdentifer;
        emit(ThemeConfigLoaded(themeIdentifer: themeId));
      }
    });
  }
}
