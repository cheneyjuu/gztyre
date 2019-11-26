import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/commen/Global.dart';
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

  _set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromRGBO(46, 105, 171, 1),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: UserInfoWidget(userInfo: Global.userInfo,),
            ),
            Container(
              color: Color.fromRGBO(231, 233, 234, 1),
              child: Padding(
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
            ),
            Expanded(
              child: Container(
                color: Color.fromRGBO(231, 233, 234, 1),
                child: ButtonBarWidget(
                  color: Color.fromRGBO(0, 0, 0, 0),
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
              ),
            )
          ],
        ),

      ),
    );
  }
}