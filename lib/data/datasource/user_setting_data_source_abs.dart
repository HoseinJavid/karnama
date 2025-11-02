import 'package:karnama/model/model.dart';

abstract class IUserSettingDataSource {
  //CRUD user setting model 
  //include theme setting user 
  Future<UserSetting?> getUserSetting();
  Future<void> updateThemeUserSetting(UserSetting usersetting);
  Future<void> initialUserSetting(UserSetting usersetting);
}