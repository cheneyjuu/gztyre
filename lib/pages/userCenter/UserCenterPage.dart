import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ButtonBarWidget.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/UserInfoWidget.dart';
import 'package:gztyre/pages/login/LoginPage.dart';
import 'package:gztyre/pages/userCenter/PasswordModifyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserCenterPage extends StatelessWidget {
  UserCenterPage({Key key, @required this.rootContext})
      : assert(rootContext != null),
        super(key: key);

  final BuildContext rootContext;

  final list = [
    {
      "title": "工单A",
      "level": "1级",
      "status": "已完成",
      "description": "打发打发到发似懂非",
      "position": "炼胶厂",
      "device": "注塑机",
      "isStop": false
    },
    {
      "title": "工单B",
      "level": "1级",
      "status": "维修中",
      "description": "打发打发到发似懂非懂克拉副驾驶登录福建省地方i啦是的就放i啊啥的飞机啊塑料袋封口机反对嘎嘎发的噶地方噶蛋糕阿斯顿发送到发萨噶说噶蛋糕料袋封口机",
      "position": "第一好工厂",
      "device": "注塑机",
      "isStop": false
    },
    {
      "title": "工单C",
      "level": "1级",
      "status": "未完成",
      "description": "打发打发到发似懂非懂克拉副驾驶登录福建省地方i啦是的就放i啊啥的飞机啊塑料袋封口机",
      "position": "炼胶厂",
      "device": "注塑机",
      "isStop": false
    }
  ];

  _set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("个人中心", style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: UserInfoWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  ListItemWidget(
                    onTap: () {
                      Navigator.of(rootContext).push(CupertinoPageRoute(builder: (BuildContext context) {
                        return PasswordModifyPage();
                      }));
                    },
                    title: Text(
                      "修改密码",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ButtonBarWidget(
                button: Container(
                  child:
                  ButtonWidget(
                    child: Text('退出登录'),
                    color: Color.fromRGBO(163, 6, 6, 1),
                    onPressed: () async {
                      await this._set("token", null);
                      Navigator.of(rootContext).pushAndRemoveUntil(
                          CupertinoPageRoute(builder: (BuildContext context) {
                          return LoginPage();
                          }), (route) {
                            return true;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}