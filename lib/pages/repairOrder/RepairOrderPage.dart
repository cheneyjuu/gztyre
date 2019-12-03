import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/ReportOrder.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/commen/Global.dart';
import 'package:gztyre/components/ButtonBarWidget.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/OrderInfoWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/pages/ContainerPage.dart';
import 'package:gztyre/pages/repairOrder/RepairDetailPage.dart';
import 'package:gztyre/pages/repairOrder/RepairHistoryPage.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderDetailPage.dart';

class RepairOrderPage extends StatefulWidget {
  RepairOrderPage({Key key, @required this.order}) : super(key: key);

  final Order order;

  @override
  State createState() {
    return _RepairOrderPageState();
  }
}

class _RepairOrderPageState extends State<RepairOrderPage> {

  bool _loading = false;
  UserInfo _userInfo;
  var _reportOrderDetailFuture;
  ReportOrder _reportOrder = new ReportOrder();

  _reportOrderDetail() async {
    this._loading = true;
    await HttpRequest.reportOrderDetail(widget.order.QMNUM,
            (ReportOrder order) {
          this._reportOrder = order;
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

  @override
  void initState() {
    this._userInfo = Global.userInfo;
    this._reportOrderDetailFuture = _reportOrderDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._reportOrderDetailFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ProgressDialog(
          loading: this._loading,
          child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoNavigationBarBackButton(
                onPressed: () => Navigator.pop(context),
                color: Color.fromRGBO(94, 102, 111, 1),
              ),
              middle: Text(
                this._reportOrder.QMTXT ?? '',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  OrderInfoWidget(
                    reportOrder: this._reportOrder,
                    order: widget.order,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        ListItemWidget(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ImageIcon(
                                AssetImage("assets/images/icon/icon_detail.png"),
                                size: 16,
                                color: Color.fromRGBO(60, 115, 240, 1),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "工单详情",
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (BuildContext context) {
                                  return RepairOrderDetailPage(reportOrder: this._reportOrder,);
                                }));
                          },
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListItemWidget(
                          title: Row(
                            children: <Widget>[
                              ImageIcon(
                                AssetImage('assets/images/icon/icon_repair.png'),
                                color: Color.fromRGBO(10, 65, 150, 1),
                                size: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "维修详情",
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            if (widget.order.ASTTX == "新建") {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      content: Text(
                                        "无维修详情",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("好"),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return RepairDetailPage();
                                  }));
                            }
                          },
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListItemWidget(
                          title: Row(
                            children: <Widget>[
                              ImageIcon(
                                AssetImage('assets/images/icon/icon_time.png'),
                                color: Color.fromRGBO(250, 90, 50, 1),
                                size: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "维修记录",
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            if (widget.order.ASTTX == "新建") {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      content: Text(
                                        "无维修记录",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("好"),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return RepairHistoryPage();
                                  }));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ButtonBarWidget(
                      button: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonWidget(
                            child: Text('转接班人'),
                            color: Color.fromRGBO(76, 129, 235, 1),
                            onPressed: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      content: Text(
                                        "是否转接班人",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("否"),
                                        ),
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                                CupertinoPageRoute(builder:
                                                    (BuildContext context) {
                                                  return ContainerPage(
                                                    rootContext: context,
                                                  );
                                                }), (route) {
                                              return true;
                                            });
                                          },
                                          child: Text("是"),
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          ButtonWidget(
                            child: Text('确认完工'),
                            color: Color.fromRGBO(163, 6, 6, 1),
                            onPressed: () {
                              if (widget.order.ASTTX == "新建") {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        content: Text(
                                          "通知单不可完工",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("好"),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        content: Text(
                                          "是否确认完工",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("否"),
                                          ),
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                  CupertinoPageRoute(builder:
                                                      (BuildContext context) {
                                                    return ContainerPage(
                                                      rootContext: context,
                                                    );
                                                  }), (route) {
                                                return true;
                                              });
                                            },
                                            child: Text("是"),
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
