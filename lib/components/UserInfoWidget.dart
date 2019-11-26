import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/model/UserInfo.dart';

class UserInfoWidget extends StatelessWidget {

  UserInfoWidget({Key key, this.userInfo}) : super(key: key);

  final UserInfo userInfo;

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
                      userInfo.ENAME,
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      userInfo.SORTT,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
//                  Padding(
//                      padding: EdgeInsets.all(5),
//                      child: Text(
//                        "13083286816",
//                        style: TextStyle(color: Colors.white, fontSize: 12),
//                      )),
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
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            userInfo.TXTMD,
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
                            size: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              userInfo.CPLTX,
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
