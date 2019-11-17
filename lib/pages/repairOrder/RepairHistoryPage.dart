import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/TimeLinePainter.dart';
import 'package:gztyre/pages/userCenter/UserInfoPage.dart';

class RepairHistoryPage extends StatefulWidget {
  @override
  State createState() {
    return RepairHistoryPageState();
  }
}

class RepairHistoryPageState extends State<RepairHistoryPage> {
  int num = 4;

  List<Widget> _buildList() {
    List<Widget> list = [];
    for (int i = 0; i < num; i++) {
      list.add(Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Row(
          children: <Widget>[
            Text("2019-10-15 09:30"),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return UserInfoPage();
                    }
                ));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(" 枣子哥", style: TextStyle(color: Color.fromRGBO(36, 98, 204, 1)),),
              ),
            ),
            Text("接单"),
          ],
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
        middle: Text(
          /// todo
          "维修记录",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      child: SafeArea(
//          child: Row(
//        children: <Widget>[
          child: SingleChildScrollView(
//            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 20,),
                      child: CustomPaint(
                        size: Size(20, (num * 10 + num * 45).toDouble()),
                        isComplex: false,
                        painter: TimeLinePainter(num: num),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 22, left: 20,),
                      child: Column(
                        children: <Widget>[
                          ..._buildList()
                        ],
                      ),
                    ),
                  ],
              ),
//            ),
          )
//            )
//        ],
//      )
      ),
    );
  }
}
