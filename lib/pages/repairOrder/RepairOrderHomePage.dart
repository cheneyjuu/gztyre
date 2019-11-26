import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/commen/Global.dart';
import 'package:gztyre/components/OrderCardWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/components/UserInfoWidget.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderPage.dart';

class RepairOrderHomePage extends StatefulWidget {
  RepairOrderHomePage({Key key, @required this.rootContext})
      : assert(rootContext != null),
        super(key: key);

  final BuildContext rootContext;

  @override
  State createState() {
    return new _RepairOrderHomePageState();
  }
}

class _RepairOrderHomePageState extends State<RepairOrderHomePage> {
  final list = [
    {
      "title": "工单A",
      "level": "1级",
      "status": "维修中",
      "description":
          "这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。",
      "position": "炼胶厂",
      "device": "注塑机",
      "isStop": false
    },
    {
      "title": "工单B",
      "level": "1级",
      "status": "维修中",
      "description":
          "这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。",
      "position": "炼胶厂",
      "device": "注塑机",
      "isStop": false
    },
    {
      "title": "工单C",
      "level": "1级",
      "status": "维修中",
      "description":
          "这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。这是测试描述，假数据，假数据。",
      "position": "炼胶厂",
      "device": "注塑机",
      "isStop": false
    }
  ];

  bool _loading = false;
  UserInfo _userInfo;
  List<Order> _list;

  Future<Null> onHeaderRefresh() {
//    this._list = [];
//    return HttpRequest.listOrder(
//        this._userInfo.PERNR,
//        this._userInfo.CPLGR,
//        this._userInfo.MATYP,
//        this._userInfo.SORTB,
//        this._userInfo.WCTYPE,
//        '', (List<Order> list) {
//      for (int i = 0; i < list.length; i++) {
//        if (list[i].PERNR == this._userInfo.PERNR) {
//          this._list.add(list[i]);
//        }
//      }
//    }, (err) {
//      print(err);
//    });
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    this._userInfo = Global.userInfo;
    super.initState();
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
              child: UserInfoWidget(
                userInfo: this._userInfo,
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromRGBO(231, 233, 234, 1),
                child: CupertinoScrollbar(
                  child: Refresh(
                    onFooterRefresh: null,
                    onHeaderRefresh: onHeaderRefresh,
                    child: ListView.custom(
                      childrenDelegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return new OrderCardWidget(
                            title: list[index]['title'],
                            level: list[index]['level'],
                            status: list[index]['status'],
                            description: list[index]['description'],
                            position: list[index]['position'],
                            device: list[index]['device'],
                            isStop: list[index]['isStop'],
                            onTap: () {
                              Navigator.of(widget.rootContext)
                                  .push(CupertinoPageRoute(builder: (context) {
                                return RepairOrderPage();
                              }));
                            },
                          );
                        },
                        childCount: 3,
                      ),
                      shrinkWrap: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
