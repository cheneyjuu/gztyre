import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ButtonBarWidget.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/ListItemSwitchWidget.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/TextareaWidget.dart';
import 'package:gztyre/components/TextareaWithPicAndVideoWidget.dart';
import 'package:gztyre/pages/problemReport/DeviceSelectionPage.dart';
import 'package:gztyre/pages/problemReport/ProblemDescriptionPage.dart';
import 'package:gztyre/pages/problemReport/RepairTypePage.dart';
import 'package:gztyre/utils/ListController.dart';

class ProblemReportHomePage extends StatefulWidget {
  ProblemReportHomePage({Key key, @required this.rootContext})
      : assert(rootContext != null),
        super(key: key);

  final BuildContext rootContext;

  @override
  State createState() {
    return new _ProblemReportHomePageState();
  }
}

class _ProblemReportHomePageState extends State<ProblemReportHomePage> {
  bool _isStop = false;
  TextEditingController _description = TextEditingController();
  TextEditingController _remark = TextEditingController();
  ListController _list = ListController(list: []);

  String _device = '';
  String _repairType = '故障维修';
  String _problemDescription = '';

//  List<String> _list = [];

  _buildTextareaWithPicAndVideoWidget() {
    print({'this.list': this._list.value});
    return TextareaWithPicAndVideoWidget(
//      callback: (List<String> list) {
//        print({'callback.list': list.length});
//        setState(() {
//          this._list.value = list;
//        });
//      },
//      list: this._list,
      listController: this._list,
      rootContext: widget.rootContext,
      textEditingController: this._description,
      placeholder: "补充故障描述...",
      lines: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("故障上报", style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListItemWidget(
                    title: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage('assets/images/icon/icon_device.png'),
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: this._device.length == 0
                              ? Text("报修对象")
                              : Text(
                            this._device,
                            style: TextStyle(
                                color: Color.fromRGBO(
                                  52,
                                  115,
                                  178,
                                  1,
                                )),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(widget.rootContext).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return DeviceSelectionPage(
                          selectItem: this._device,
                        );
                      })).then((value) {
                        this._device = value;
                      });
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListItemSwitchWidget(
                    title: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage('assets/images/icon/icon_stop.png'),
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("是否停机"),
                        )
                      ],
                    ),
                    isStop: this._isStop,
                    onChanged: (bool isStop) {
                      this._isStop = isStop;
                      setState(() {});
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
                          child: this._repairType.length == 0
                              ? Text("维修类型")
                              : Text(
                            this._repairType,
                            style: TextStyle(
                                color: Color.fromRGBO(52, 115, 178, 1)),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(widget.rootContext).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return RepairTypePage(
                          selectItem: this._repairType,
                        );
                      })).then((value) {
                        this._repairType = value;
                      });
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListItemWidget(
                    title: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage('assets/images/icon/icon_description.png'),
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: this._problemDescription.length == 0
                              ? Text("故障描述")
                              : Text(
                            this._problemDescription,
                            style: TextStyle(
                                color: Color.fromRGBO(52, 115, 178, 1)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(widget.rootContext).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return ProblemDescriptionPage(
                          selectItem: this._problemDescription,
                        );
                      })).then((value) {
                        this._problemDescription = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: _buildTextareaWithPicAndVideoWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: TextareaWidget(
                      textEditingController: this._remark,
                      placeholder: "备注...",
                      lines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBarWidget(
                button: Container(
                  child: ButtonWidget(
                    child: Text('上报故障'),
                    color: Color.fromRGBO(76, 129, 235, 1),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              content: Text(
                                "是否上报故障",
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
                                    setState(() {
                                      this._device = '';
                                      this._repairType = '故障维修';
                                      this._problemDescription = '';
                                      this._description =
                                          new TextEditingController();
                                      this._remark =
                                          new TextEditingController();
                                      this._list.value = new List();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("是"),
                                )
                              ],
                            );
                          });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
