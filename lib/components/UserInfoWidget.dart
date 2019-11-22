import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundImage: new AssetImage('assets/images/user.jpeg'),
              radius: 50,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "枣子哥",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "炼胶厂",
                      style: TextStyle(color: Color.fromRGBO(40, 44, 52, 1)),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "空调区域",
                        style: TextStyle(color: Color.fromRGBO(40, 44, 52, 1)),
                      )),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "跟班维修",
                      style: TextStyle(color: Color.fromRGBO(40, 44, 52, 1)),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "13083286816",
                        style: TextStyle(color: Color.fromRGBO(40, 44, 52, 1)),
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
