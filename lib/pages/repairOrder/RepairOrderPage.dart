import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ButtonBarWidget.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/OrderInfoWidget.dart';
import 'package:gztyre/pages/ContainerPage.dart';
import 'package:gztyre/pages/repairOrder/RepairDetailPage.dart';
import 'package:gztyre/pages/repairOrder/RepairHistoryPage.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderDetailPage.dart';

class RepairOrderPage extends StatefulWidget {
  @override
  State createState() {
    return _RepairOrderPageState();
  }
}

class _RepairOrderPageState extends State<RepairOrderPage> {
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
          "报修工单标题",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            OrderInfoWidget(),
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
                          color: Colors.grey,
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
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return RepairOrderDetailPage();
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
                          color: Colors.grey,
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
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return RepairDetailPage();
                      }));
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListItemWidget(
                    title: Row(
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/images/icon/icon_time.png'), color: Colors.grey,),
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
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return RepairHistoryPage();
                      }));
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
                                      Navigator.of(context).pushAndRemoveUntil(
                                          CupertinoPageRoute(
                                              builder: (BuildContext context) {
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
                                      Navigator.of(context).pushAndRemoveUntil(
                                          CupertinoPageRoute(
                                              builder: (BuildContext context) {
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
