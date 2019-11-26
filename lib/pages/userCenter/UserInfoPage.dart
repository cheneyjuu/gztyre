import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/UserInfoWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({Key key, this.userInfo}): super(key: key);

  final UserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
//        middle: Text(
//          /// todo
//          "报修工单标题",
//          style: TextStyle(fontWeight: FontWeight.w100),
//        ),
      ),
      child: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: UserInfoWidget(userInfo: this.userInfo,),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                ListItemWidget(
                  onTap: () {
//                    launch("tel:13083286816");
                  },
                  title: Text(
                    "呼叫用户",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
