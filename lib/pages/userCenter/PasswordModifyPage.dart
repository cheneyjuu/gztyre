import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ButtonBarWidget.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/InputWidget.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/TextButtonWidget.dart';

class PasswordModifyPage extends StatefulWidget {
  PasswordModifyPage({
    Key key,
  }) : super(key: key);

  @override
  State createState() => PasswordModifyPageState();
}

class PasswordModifyPageState extends State<PasswordModifyPage> {
  TextEditingController _oldPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
        middle: Text(
          "修改密码",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      child: SafeArea(
          child: CupertinoScrollbar(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: InputWidget(
                controller: this._oldPasswordController,
                obscureText: true,
                prifixMode: OverlayVisibilityMode.never,
                placeholderText: "请输入原密码",
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: InputWidget(
                controller: this._newPasswordController,
                obscureText: true,
                prifixMode: OverlayVisibilityMode.never,
                placeholderText: "请输入新密码",
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: InputWidget(
                controller: this._confirmPasswordController,
                obscureText: true,
                prifixMode: OverlayVisibilityMode.never,
                placeholderText: "请再次输入新密码",
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Expanded(
              child: ButtonBarWidget(
                button: Container(
                  child:
                  ButtonWidget(
                    child: Text("确认修改"),
                    color: Color.fromRGBO(33, 127, 184, 1),
                    onPressed: () {
//                      await this._set("token", null);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
