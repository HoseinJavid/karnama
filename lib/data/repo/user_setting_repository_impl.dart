import 'package:karnama/data/datasource/local_hive_user_setting_data_source_impl.dart';
import 'package:karnama/data/datasource/user_setting_data_source_abs.dart';
import 'package:karnama/model/model.dart';

class UserSettingRepository extends IUserSettingDataSource {
  final LocalHiveUserSettingDataSourceImpl local;

  UserSettingRepository({required this.local});
  @override
  Future<UserSetting?> getUserSetting() {
    return local.getUserSetting();
  }

  @override
  Future<void> initialUserSetting(UserSetting usersetting) async {
    local.initialUserSetting(usersetting);
  }

  @override
  Future<void> updateThemeUserSetting(UserSetting usersetting) async {
    local.updateThemeUserSetting(usersetting);
  }

  @override
  Future<void> updateAllUserSetting(UserSetting usersetting) async {
    local.updateAllUserSetting(usersetting);
  }
}
