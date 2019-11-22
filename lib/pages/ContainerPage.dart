import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gztyre/components/TabBarIcon.dart';
import 'package:gztyre/components/TextButtonWidget.dart';
import 'package:gztyre/pages/problemReport/ProblemReportHomePage.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderHomePage.dart';
import 'package:gztyre/pages/userCenter/UserCenterPage.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key, @required this.rootContext,}) : super(key: key);

  final BuildContext rootContext;

  @override
  State createState() {
    return new _ContainerPageState();
  }
}

class _ContainerPageState extends State<ContainerPage> {
  var pages;
  var _selectPage;

  @override
  void initState() {
    super.initState();
    pages = [
      RepairOrderHomePage(rootContext: widget.rootContext),
      ProblemReportHomePage(rootContext: widget.rootContext),
      UserCenterPage(rootContext: widget.rootContext),
    ];
  }

  Widget _buildPage(int i) {
    return Center(
      child: pages[i],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(

        tabBar: CupertinoTabBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: TabBarIcon(
                image: AssetImage("assets/images/icon/icon_repair.png"),
                title: "我的报修单",
              ),
              activeIcon: TabBarIcon(
                image: AssetImage("assets/images/icon/icon_repair.png"),
                title: "我的报修单",
                isActive: true,
              )),
          BottomNavigationBarItem(
            icon: TabBarIcon(
              image: AssetImage("assets/images/icon/icon_report.png"),
              title: "故障上报",
            ),
            activeIcon: TabBarIcon(
              image: AssetImage("assets/images/icon/icon_report.png"),
              title: "故障上报",
              isActive: true,
            ),
          ),
          BottomNavigationBarItem(
            icon: TabBarIcon(
              image: AssetImage("assets/images/icon/icon_user.png"),
              title: "个人中心",
            ),
            activeIcon: TabBarIcon(
              image: AssetImage("assets/images/icon/icon_user.png"),
              title: "个人中心",
              isActive: true,
            ),
          ),
        ]),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return _buildPage(index);
            },
          );
        });
  }
}
