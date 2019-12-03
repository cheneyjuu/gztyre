import 'package:flutter/cupertino.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/HttpRequestRest.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/commen/Global.dart';
import 'package:gztyre/components/OrderCardLiteWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/pages/orderCenter/OrderDetailPage.dart';

class OrderListPage extends StatefulWidget {
  @override
  State createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  var _listRepairOrderFuture;

  bool _loading = false;
  UserInfo _userInfo;
  List<Order> _list;

//  List _extendList;

  _listRepairOrder() async {
    this._loading = true;
    this._list = [];
    HttpRequest.listOrder(this._userInfo.PERNR, null, null, null, "X", null,
        (List list) {
      list.forEach((item) {
        if (item.QMNUM != null && item.QMNUM != '') {
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
      await HttpRequest.listOrder(
          this._userInfo.PERNR, null, null, null, "X", null,
          (List<Order> list) {
        list.forEach((item) {
          if (item.QMNUM != null && item.QMNUM != '') {
            this._list.add(item);
          }
        });
        setState(() {});
      }, (err) {
        print(err);
        setState(() {});
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
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoNavigationBarBackButton(
                onPressed: () => Navigator.pop(context),
                color: Color.fromRGBO(94, 102, 111, 1),
              ),
              middle:
                  Text("新订单", style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
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
                                return new OrderCardLiteWidget(
                                  title: this._list[index].QMNUM ?? '',
                                  /// todo
                                  level: "1级",
                                  status: this._list[index].ASTTX ?? '',
                                  position: this._list[index].PLTXT ?? '',
                                  device: this._list[index].EQKTX ?? '',
                                  isStop: true,
                                  onTap: () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (BuildContext context) {
                                      return OrderDetailPage(order: this._list[index]);
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
