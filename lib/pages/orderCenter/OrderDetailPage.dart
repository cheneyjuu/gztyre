import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/components/ButtonBarWidget.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/TextButtonWidget.dart';
import 'package:gztyre/components/ViewDialog.dart';
import 'package:gztyre/pages/orderCenter/OrderRepairDetailPage.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key, this.order}) : super(key: key);

  final Order order;
  @override
  State createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  bool _isReairing;

  List<Widget> _buildPic() {
    List<Widget> list = [];
    for (int i = 0; i < 6; i++) {
      list.add(GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Image.asset('assets/images/user.jpeg'),
        ),
        onTap: () {
          Navigator.of(context).push(new CupertinoPageRoute(
              builder: (context) => new ViewDialog(
                    img: {'key': 'test', 'asset': 'assets/images/user.jpeg'},
                    imgs: [
                      {'key': 'test', 'asset': 'assets/images/user.jpeg'},
                      {'key': 'test2', 'asset': 'assets/images/user.jpeg'}
                    ],
                    onlyView: true,
                  )));
        },
      ));
    }
    return list;
  }


  @override
  void initState() {
    super.initState();
    this._isReairing = false;
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
          widget.order.QMNUM,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: TextButtonWidget(text: "转卡", onTap: () {},),
      ),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            ListItemWidget(title: Text("报修人")),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Text(
                '每拉他更路斯文约设周于教还算照组分还反八标石第从号情战持酸细们问人共么千反但象设目民理合先般放教众严商却记前为还众儿天议备然无叫力候白思利团声种资',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[..._buildPic()],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBarWidget(
                  button: this._isReairing ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonWidget(
                          child: Text('呼叫协助'),
                          color: Color.fromRGBO(76, 129, 235, 1),
                          onPressed: () {

                          }),
                      ButtonWidget(
                          child: Text('维修'),
                          color: Color.fromRGBO(12, 160, 170, 1),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) {
                              return OrderRepairDetailPage();
                            }));
                          })
                    ],
                  ) : ButtonWidget(
                      child: Text('接单'),
                      color: Color.fromRGBO(76, 129, 235, 1),
                      onPressed: () {
                        setState(() {
                          this._isReairing = true;
                        });
                      })
                  ),
            )
          ],
        ),
      ),
    );
  }
}
