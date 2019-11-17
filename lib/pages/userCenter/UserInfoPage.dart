import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/UserInfoWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoPage extends StatelessWidget {
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
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
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
