import 'package:gztyre/api/model/Device.dart';
import 'package:gztyre/api/model/FunctionPosition.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/RepairType.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/api/model/WorkShift.dart';
//import 'package:gztyre/commen/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Global {
  static SharedPreferences prefs;
  /// 功能位置
  static FunctionPosition functionPosition = FunctionPosition();
  /// 用户信息
  static UserInfo userInfo = UserInfo();
  /// 工作中心
  static WorkShift workShift = WorkShift();

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
//  static Profile profile = Profile();

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
//    var _profile = _prefs.getString("profile");
//    if (_profile != null) {
//      try {
//        profile = Profile.fromJson(jsonDecode(_profile));
//      } catch (e) {
//        print(e);
//      }
//    }

//    // 如果没有缓存策略，设置默认缓存策略
//    profile.cache = profile.cache ?? CacheConfig()
//      ..enable = true
//      ..maxAge = 3600
//      ..maxCount = 100;
//
//    //初始化网络请求相关配置
//    Git.init();
  }

//  // 持久化Profile信息
//  static saveProfile() =>
//      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
