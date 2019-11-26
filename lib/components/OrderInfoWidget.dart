import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderInfoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: Text('接   单   人：小虎', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('接单时间：11-11 00:00', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('功能位置：空调区域', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
                child: Text('故障设备：空调外机故障', style: TextStyle(fontSize: 14),),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: Text('工单进度：已完工', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('完工时间：11-11 22:00', style: TextStyle(fontSize: 14),),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('是否停机：否', style: TextStyle(fontSize: 14),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
