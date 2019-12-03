import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/HttpRequestRest.dart';
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
  var _listRepairOrderFuture;

  bool _loading = false;
  UserInfo _userInfo;
  List<Order> _list;

//  List _extendList;

  _listRepairOrder() async {
    this._loading = true;
    this._list = [];
    await HttpRequest.listOrder(this._userInfo.PERNR, null, null, null, "X", null,
        (List<Order> list) {
      list.forEach((item) {
        if (item.PERNR == this._userInfo.PERNR) {
          this._list.add(item);
        }
      });
      setState(() {
        this._loading = false;
      });
    }, (err) {
      print(err);
      setState(() {
        this._loading = false;
      });
    });
  }

  Future<Null> onHeaderRefresh() {
    this._list = [];
    return new Future(() async {
      await HttpRequest.listOrder(this._userInfo.PERNR, null, null, null, "X", null,
          (List list) {
        list.forEach((item) {
          if (item.PERNR == this._userInfo.PERNR) {
            this._list.add(item);
          }
        });
        setState(() {
          this._loading = false;
        });
      }, (err) {
        print(err);
        setState(() {
          this._loading = false;
        });
      });
    });
  }

  @override
  void initState() {
    this._userInfo = Global.userInfo;
    this._listRepairOrderFuture = this._listRepairOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._listRepairOrderFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ProgressDialog(
          loading: this._loading,
          child: CupertinoPageScaffold(
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
                                  title: this._list[index].QMNUM ?? '',
                                  level: "1级",
                                  status: this._list[index].ASTTX ?? '',
                                  description: this._list[index].QMTXT ?? '',
                                  position: this._list[index].PLTXT ?? '',
                                  device: this._list[index].EQKTX ?? '',
                                  isStop: true,
                                  onTap: () {
                                    Navigator.of(widget.rootContext).push(
                                        CupertinoPageRoute(builder: (context) {
                                      return RepairOrderPage(
                                        order: this._list[index],
                                      );
                                    }));
                                  },
                                );
                              },
                              childCount: this._list.length,
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
          ),
        );
      },
    );
  }
}
