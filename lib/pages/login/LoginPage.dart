import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/InputWidget.dart';
import 'package:gztyre/pages/login/WorkShiftSelectionPage.dart';
import 'package:gztyre/utils/screen_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _rememberUsername = true;
  bool _rememberPassword = true;
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this._usernameController.text = "12345";
    this._passwordController.text = "12345";
    _get("isRememberUsername").then((String val) {
      if ('0' == val) {
        _rememberUsername = false;
      } else {
        _rememberUsername = true;
      }
    });
    _get("isRememberPassword").then((String val) {
      if ('0' == val) {
        _rememberPassword = false;
      } else {
        _rememberPassword = true;
      }
    });
    _get("username").then((String username) {
      _usernameController.text = username;
    });
    _get("password").then((String password) {
      _passwordController.text = password;
    });
  }

  Future<String> _get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key);
  }

  _set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.fitWidth,
    );

    Widget inputArea = Form(
      autovalidate: true,
      child: Column(
        children: <Widget>[
          InputWidget(
            controller: _usernameController,
            prefixText: "工号",
            placeholderText: "请输入工号",
            keyboardType: TextInputType.number,
          ),
          InputWidget(
            controller: _passwordController,
            prefixText: "密码",
            placeholderText: "请输入密码",
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
        ],
      ),
    );

    Widget operationArea = Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
              '忘记密码？',
              style: TextStyle(color: Color.fromRGBO(44, 93, 187, 1), fontSize: 14),
              overflow: TextOverflow.fade,
            ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CupertinoSwitch(
                    value: _rememberUsername,
                    onChanged: (val) {
                      setState(() {
                        _rememberUsername = val;
                      });
                    }),
                Expanded(
                  child: Text(
                    "记住账号",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CupertinoSwitch(
                    value: _rememberPassword,
                    onChanged: (val) {
                      setState(() {
                        _rememberPassword = val;
                      });
                    }),
                Expanded(
                  child: Text(
                    "记住密码",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    return new CupertinoPageScaffold(
        child: ListView(
      children: <Widget>[
        new SafeArea(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtils.screenW(context) * 0.15),
            child: logo,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtils.screenH(context) / 10),
          child: inputArea,
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
          child: ButtonWidget(
            child: Text(
              "登录",
              style: TextStyle(fontSize: 20),
            ),
            color: Color.fromRGBO(51, 115, 178, 1),
            onPressed: () async {
              if (_rememberUsername) {
                await _set("username", _usernameController.text);
              } else {
                await _set("username", null);
              }
              if (_rememberPassword) {
                await _set("password", _passwordController.text);
              } else {
                await _set("password", null);
              }
              await Navigator.push(
                  context,
                  new CupertinoPageRoute(
                      builder: (context) => new WorkShiftSelectionPage()));
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: operationArea,
        )
      ],
    ));
  }
}
