import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color.fromRGBO(46, 105, 171, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundImage: new AssetImage('assets/images/user.jpeg'),
              radius: 32,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "枣子哥",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "跟班维修",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "13083286816",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage('assets/images/icon/icon_factory.png'),
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "炼胶厂",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child:  Row(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage('assets/images/icon/icon_position.png'),
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "空调区域",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          )
                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
