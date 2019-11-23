import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gztyre/pages/ContainerPage.dart';
import 'package:gztyre/pages/login/LoginPage.dart';
import 'package:gztyre/pages/login/MaintenanceGroupSelectionPage.dart';
import 'package:gztyre/pages/login/WorkShiftSelectionPage.dart';
import 'package:gztyre/pages/problemReport/DeviceSelectionPage.dart';
import 'package:gztyre/pages/problemReport/ProblemDescriptionPage.dart';
import 'package:gztyre/pages/problemReport/RepairTypePage.dart';
import 'package:gztyre/pages/repairOrder/RepairDetailPage.dart';
import 'package:gztyre/pages/repairOrder/RepairHistoryPage.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderDetailPage.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderHomePage.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderPage.dart';
import 'package:gztyre/pages/userCenter/UserInfoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        primaryColor: Color.fromRGBO(253, 255, 255, 1),
        scaffoldBackgroundColor: Color.fromRGBO(231, 233, 234, 1)
      ),
      home: EntryWidget(),
//      routes: <String, WidgetBuilder> {
//        "login": (BuildContext context) => LoginPage(),
//        "container": (BuildContext context) => ContainerPage(),
//      },
    );
  }
}

class EntryWidget extends StatefulWidget {
  EntryWidget({Key key}) : super(key: key);


  @override
  _EntryWidgetState createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {

  bool _hasToken = false;

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get("token") != null;
  }


  @override
  void initState() {
    hasToken().then((val) {
      _hasToken = val;
      print(val);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    if (!_hasToken) {
      return new LoginPage();
//    } else {
//      return new ContainerPage(rootContext: context,);
//      return new RepairOrderPage();
//      return new RepairOrderDetailPage();
//      return new RepairDetailPage();
//      return new RepairHistoryPage();
//      return new UserInfoPage();
//      return new DeviceSelectionPage();
//      return new RepairTypePage();
//      return new ProblemDescriptionPage();
//    }
  }
}
