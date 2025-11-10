import 'package:hive/hive.dart';
import 'package:karnama/constant.dart';
import 'package:karnama/data/datasource/user_setting_data_source_abs.dart';
import 'package:karnama/model/model.dart';

class LocalHiveUserSettingDataSourceImpl extends IUserSettingDataSource {
  final Box<UserSetting> usersettingBox;

  LocalHiveUserSettingDataSourceImpl({required this.usersettingBox});
  @override
  Future<UserSetting?> getUserSetting() async {
    return usersettingBox.get(keyUserSetting);
  }

  @override
  Future<void> updateThemeUserSetting(UserSetting usersetting) async {
    final user = usersettingBox.get(keyUserSetting);
    if (user == null) {
      throw Exception(
          'User setting not found for key: $keyUserSetting');
    } else {
      user.themeIdentifer = usersetting.themeIdentifer;
      usersettingBox.put(keyUserSetting, user);
      
    }
  }
  
  @override
  Future<void> initialUserSetting(UserSetting usersetting) async{
   await usersettingBox.put(keyUserSetting, usersetting);
  }
  
  @override
  Future<void> updateAllUserSetting(UserSetting usersetting)async {
   await initialUserSetting(usersetting);
  }
}
