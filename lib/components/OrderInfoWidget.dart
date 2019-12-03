import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/ReportOrder.dart';

class OrderInfoWidget extends StatelessWidget {
  OrderInfoWidget({Key key, this.order, this.reportOrder}): super(key: key);

  final ReportOrder reportOrder;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: Text('接   单   人：${order.PERNR1 == '' || order.PERNR == null ? '无' : order.PERNR}', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('接单时间：${order.acceptTime ?? '无'}', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('功能位置：${order.PLTXT ?? '无'}', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
                child: Text('故障设备：${order.EQKTX ?? '无'}', style: TextStyle(fontSize: 14),),
              )
            ],
          )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: Text('工单进度：${order.ASTTX ?? '无'}', style: TextStyle(fontSize: 14),),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('完工时间：${order.completeTime ?? '无'}', style: TextStyle(fontSize: 14),),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('是否停机：${reportOrder.MSAUS == true ? '是' : "否"}', style: TextStyle(fontSize: 14),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
