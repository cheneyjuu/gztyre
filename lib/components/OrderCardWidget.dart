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
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(offset: Offset.zero, spreadRadius: 1, color: Color.fromRGBO(225, 225, 225, 1))],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//            Expanded(
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              widget.level,
                              style: TextStyle(
                                  color: Color.fromRGBO(218, 4, 27, 1),
                                  fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(
                                color: Color.fromRGBO(218, 4, 27, 1), fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[


                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child:  Text(
                                    "${widget.isStop ? "已停机" : "未停机"}",
                                    style: TextStyle(
                                        fontSize: 14,),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  widget.status,
                                  style: TextStyle(
                                      color: Color.fromRGBO(218, 4, 27, 1),
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
//            ),
//            Expanded(
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Expanded(
//                      child: Text(
//                        "报修时长",
//                        style: TextStyle(fontSize: 15),
//                        maxLines: 1,
//                        overflow: TextOverflow.ellipsis,
//                      ),
//                    ),
//                    widget.status == "已完成" ? Expanded(
//                      child: Text(
//                        "等待时长",
//                        style: TextStyle(fontSize: 15),
//                        maxLines: 1,
//                        overflow: TextOverflow.ellipsis,
//                      ),
//                    ) : Container(),
//                  ],
//                ),
//            ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.description,
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.65), fontSize: 12),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
//            Expanded(

//            ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1,),
              Container(
                decoration: BoxDecoration(
//                  color: Color.fromRGBO(225, 225, 225, 1),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5) )
                ),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "位置：",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 12),
                                ),
                                Text(
                                  widget.position,
                                  style: TextStyle(
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),Row(
                              children: <Widget>[
                                Text(
                                  "报修：",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 12),
                                ),
                                Text(
                                  "1天12时25分",
                                  style: TextStyle(
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
//                    Expanded(
//                      flex: 2,
//                      child: Padding(
//                        padding: EdgeInsets.all(10),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              "设备",
//                              style: TextStyle(
//                                  color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 12),
//                            ),
//                            Text(
//                              widget.device,
//                              style: TextStyle(
//                                  fontSize: 14),
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "设备：",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 12),
                                ),
                                Text(
                                  widget.device,
                                  style: TextStyle(
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "等待：",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 12),
                                ),
                                Text(
                                  "1天10时30分",
                                  style: TextStyle(
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
//                    Expanded(
//                      flex: 3,
//                      child: Padding(
//                        padding: EdgeInsets.all(10),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              "等待时长",
//                              style: TextStyle(
//                                  color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 12),
//                            ),
//                            Text(
//                              "1天10时30分",
//                              style: TextStyle(
//                                  fontSize: 14),
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                      child: Text(
//                        "设备：${widget.device}",
//                        style: TextStyle(
//                            color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
//                        maxLines: 1,
//                        overflow: TextOverflow.ellipsis,
//                      ),
//                    ),
//                    Expanded(
//                      child: Text(
//                        "${widget.isStop ? "已停机" : "未停机"}",
//                        style: TextStyle(
//                            color: Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
//                        maxLines: 1,
//                        overflow: TextOverflow.ellipsis,
//                      ),
//                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
