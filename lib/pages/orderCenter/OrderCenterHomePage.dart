import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/pages/orderCenter/OrderListPage.dart';

class OrderCenterHomePage extends StatelessWidget {
  OrderCenterHomePage({Key key, @required this.rootContext})
      : assert(rootContext != null),
        super(key: key);

  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("订单中心", style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            ListItemWidget(title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  AssetImage("assets/images/icon/icon_order.png"),
                  size: 16,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "新工单",
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
              onTap: () {
              Navigator.of(rootContext).push(new CupertinoPageRoute(builder: (BuildContext context) {
                return OrderListPage();
              }));
              },
            ),
            Divider(
              height: 1,
            ),
            ListItemWidget(title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  AssetImage("assets/images/icon/icon_order.png"),
                  size: 16,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "转卡单",
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),),
            Divider(
              height: 1,
            ),
            ListItemWidget(title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  AssetImage("assets/images/icon/icon_order.png"),
                  size: 16,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "维修中",
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),),
            Divider(
              height: 1,
            ),
            ListItemWidget(title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  AssetImage("assets/images/icon/icon_order.png"),
                  size: 16,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "协助单",
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),),
            Divider(
              height: 1,
            ),
            ListItemWidget(title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ImageIcon(
                  AssetImage("assets/images/icon/icon_order.png"),
                  size: 16,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "历史单",
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),),
/// todo
//            ListItemWidget(title: Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                ImageIcon(
//                  AssetImage("assets/images/icon/icon_order.png"),
//                  size: 16,
//                  color: Colors.black,
//                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 10),
//                  child: Text(
//                    "新工单",
//                    style: TextStyle(fontSize: 16),
//                    maxLines: 1,
//                    overflow: TextOverflow.ellipsis,
//                  ),
//                )
//              ],
//            ),)
          ],
        ),
      ),
    );
  }
}