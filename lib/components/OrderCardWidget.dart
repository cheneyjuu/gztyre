import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatefulWidget {
  OrderCardWidget({
    Key key,
    @required this.title,
    @required this.level,
    @required this.status,
    @required this.description,
    @required this.position,
    @required this.device,
    @required this.isStop,
    this.onTap
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final String level;
  final String status;
  final String description;
  final String position;
  final String device;
  final bool isStop;

  @override
  State createState() => OrderCardWidgetState();
}

class OrderCardWidgetState extends State<OrderCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 140,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//            Expanded(
                Row(
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.85), fontSize: 20),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              widget.level,
                              style: TextStyle(
                                  color: Color.fromRGBO(184, 35, 33, 100),
                                  fontSize: 15),
                            ),
                          ),
                          Text(
                            widget.status,
                            style: TextStyle(
                                color: Color.fromRGBO(184, 35, 33, 100),
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
//            ),
//            Expanded(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "报修时长",
                        style: TextStyle(fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    widget.status == "已完成" ? Expanded(
                      child: Text(
                        "等待时长",
                        style: TextStyle(fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ) : Container(),
                  ],
                ),
//            ),
                Expanded(
                  child: Text(
                    widget.description,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.65), fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
//            Expanded(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "位置：${widget.position}",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "设备：${widget.device}",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "是否停机：${widget.isStop ? "是" : "否"}",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
//            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
