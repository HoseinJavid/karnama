import 'package:bloc/bloc.dart';
import 'package:karnama/constant.dart';
import 'package:karnama/data/repo/user_setting_repository_impl.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/widgets/AlertDialog.dart';
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
          //first user login in app
          var languageCodeDefult = 'fa';
          await userSettingRepo.initialUserSetting(UserSetting(
              themeIdentifer: 'Solid_defult',
              languageCode: languageCodeDefult,
              selectedRingtone: Ringtone.defaultalarm));
          emit(ThemeConfigLoaded(
              themeIdentifer: 'Solid_defult',
              languageCode: languageCodeDefult));
        } else {
          //user already login in app
          var themeId = setting.themeIdentifer;
          var languageCode = setting.languageCode;
          emit(ThemeConfigLoaded(
              themeIdentifer: themeId, languageCode: languageCode));
        }
      }
      if (event is ChangeThemeEvent) {
        var setting = await userSettingRepo.getUserSetting();
        if (event.themeIdentifer != null) {
          setting!.themeIdentifer = event.themeIdentifer!;
        }
        if (event.languageCode != null) {
          setting!.languageCode = event.languageCode!;
        }
        userSettingRepo.updateThemeUserSetting(setting!);
        var themeId = setting.themeIdentifer;
        var languageCode = setting.languageCode;

        emit(ThemeConfigLoaded(
            themeIdentifer: themeId, languageCode: languageCode));
      }
    });
  }
}
