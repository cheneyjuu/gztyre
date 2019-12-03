import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/HttpRequestRest.dart';
import 'package:gztyre/api/model/Device.dart';
import 'package:gztyre/api/model/FunctionPosition.dart';
import 'package:gztyre/api/model/ProblemDescription.dart';
import 'package:gztyre/api/model/RepairType.dart';
import 'package:gztyre/commen/Global.dart';
import 'package:gztyre/components/ButtonBarWidget.dart';
import 'package:gztyre/components/ButtonWidget.dart';
import 'package:gztyre/components/ListItemSwitchWidget.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
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

  Device _device;
  FunctionPosition _position;
  RepairType _repairType;
  ProblemDescription _problemDescription;

  bool _loading = false;

//  List<String> _list = [];

  _buildTextareaWithPicAndVideoWidget() {
    print({'this.list': this._list.value});
    return TextareaWithPicAndVideoWidget(
      listController: this._list,
      rootContext: widget.rootContext,
      textEditingController: this._description,
      placeholder: "补充故障描述...",
      lines: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loading: this._loading,
        child: CupertinoPageScaffold(
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
                              color: Color.fromRGBO(250, 175, 30, 1),
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: this._device == null
                                  ? Text("报修对象")
                                  : Text(
                                      this._device.EQKTX,
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
                              CupertinoPageRoute(
                                  builder: (BuildContext context) {
                            return DeviceSelectionPage(
                              selectItem: this._device,
                            );
                          })).then((value) {
                            this._device = value['device'];
                            this._position = value['pos'];
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
                              color: Color.fromRGBO(250, 70, 70, 1),
                              size: 16,
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
                              color: Color.fromRGBO(10, 65, 150, 1),
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: this._repairType == null
                                  ? Text("维修类型")
                                  : Text(
                                      this._repairType.ILATX,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(52, 115, 178, 1)),
                                    ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.of(widget.rootContext).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) {
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
                              AssetImage(
                                  'assets/images/icon/icon_description.png'),
                              color: Color.fromRGBO(150, 225, 190, 1),
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: this._problemDescription == null
                                  ? Text("故障描述")
                                  : Text(
                                      this._problemDescription.KURZTEXT_CODE,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(52, 115, 178, 1)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.of(widget.rootContext).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) {
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
                          bool flag = true;
                          if (this._device == null ||
                              this._repairType == null ||
                              this._problemDescription == null) {
                            showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    content: Text(
                                      "请填写完整",
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
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            this._loading = true;
                                          });
                                          String left = '';
                                          for (var i = 0; i < 16; i++) {
                                            left = left +
                                                Random().nextInt(4).toString();
                                          }
                                          List<String> pictures = List();
                                          String video = '';
                                          if (this._list.value.length > 0) {
                                            await HttpRequestRest.upload(
                                                this._list.value.map((item) {
                                                  return item;
                                                }).toList(), (res) {
                                              res.forEach((item) {
                                                if (item["fileDownloadUri"].endsWith("mp4")) {
                                                  video = item["fileDownloadUri"];
                                                } else {
                                                  pictures.add(
                                                      item["fileDownloadUri"]);
                                                }
                                              });

                                              String sapNo = "";
                                              print(2);
                                              HttpRequest.createReportOrder(
                                                  Global.userInfo == null
                                                      ? ''
                                                      : Global.userInfo.PERNR,
                                                  Global.workShift == null
                                                      ? ''
                                                      : Global.workShift.TPLNR,
                                                  this._repairType == null
                                                      ? ''
                                                      : this._repairType.ILART,
                                                  this._device == null
                                                      ? ''
                                                      : this._device.EQUNR,
                                                  this._position == null
                                                      ? ''
                                                      : this._position.TPLNR,
                                                  this._problemDescription == null
                                                      ? ''
                                                      : this
                                                      ._problemDescription
                                                      .CODEGRUPPE,
                                                  this._problemDescription == null
                                                      ? ''
                                                      : this
                                                      ._problemDescription
                                                      .CODE,
                                                  this._description == null
                                                      ? ''
                                                      : this._description.text,
                                                  Global.userInfo == null
                                                      ? ''
                                                      : Global.userInfo.CPLGR,
                                                  Global.userInfo == null
                                                      ? ''
                                                      : Global.userInfo.MATYP,
                                                  this._isStop ? "O" : "X",
                                                  left, (res) {
                                                sapNo = res['QMNUM'];
                                                HttpRequestRest.malfunction(
                                                    left,
                                                    sapNo,
                                                    1,
                                                    pictures,
                                                    video,
                                                    this._problemDescription == null
                                                        ? ''
                                                        : this
                                                        ._problemDescription
                                                        .KURZTEXT_CODE,
                                                    this._description == null
                                                        ? ''
                                                        : this._description.text,
                                                    this._remark == null
                                                        ? ''
                                                        : this._remark.text,
                                                    this._isStop,
                                                    Global.userInfo == null
                                                        ? ''
                                                        : Global.userInfo.PERNR,
                                                    '',
                                                    '',
                                                    '新工单',
                                                    this._position == null
                                                        ? ''
                                                        : this._position.PLTXT,
                                                    this._device == null
                                                        ? ''
                                                        : this._device.EQKTX,
                                                    new DateTime.now().toString(),
                                                    '', (res) {
                                                  setState(() {
                                                    this._loading = false;
                                                  });
                                                  showCupertinoDialog(
                                                      context: widget.rootContext,
                                                      builder:
                                                          (BuildContext context) {
                                                        return CupertinoAlertDialog(
                                                          content: Text(
                                                            "上报成功",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          actions: <Widget>[
                                                            CupertinoDialogAction(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Text("好"),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                  setState(() {
                                                    this._device = null;
                                                    this._repairType = null;
                                                    this._problemDescription = null;
                                                    this._description =
                                                    new TextEditingController();
                                                    this._remark =
                                                    new TextEditingController();
                                                    this._list.value = new List();
                                                  });
                                                }, (err) {
                                                  setState(() {
                                                    this._loading = false;
                                                  });
                                                  showCupertinoDialog(
                                                      context: widget.rootContext,
                                                      builder:
                                                          (BuildContext context) {
                                                        return CupertinoAlertDialog(
                                                          content: Text(
                                                            "上报失败",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          actions: <Widget>[
                                                            CupertinoDialogAction(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Text("好"),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                });
                                              }, (err) {
                                                print(err);
                                                setState(() {
                                                  this._loading = false;
                                                });
                                                showCupertinoDialog(
                                                    context: widget.rootContext,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CupertinoAlertDialog(
                                                        content: Text(
                                                          "上报失败",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        actions: <Widget>[
                                                          CupertinoDialogAction(
                                                            onPressed: () {
                                                              Navigator.of(context)
                                                                  .pop();
                                                            },
                                                            child: Text("好"),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              });
                                            }, (err) {
                                              print(err);
                                              setState(() {
                                                this._loading = false;
                                              });
                                              flag = false;
                                              showCupertinoDialog(
                                                  context: widget.rootContext,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CupertinoAlertDialog(
                                                      content: Text(
                                                        "上报失败",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                          child: Text("好"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            });
                                          } else {
                                            String sapNo = "";
                                            print(2);
                                            await HttpRequest.createReportOrder(
                                                Global.userInfo == null
                                                    ? ''
                                                    : Global.userInfo.PERNR,
                                                Global.workShift == null
                                                    ? ''
                                                    : Global.workShift.TPLNR,
                                                this._repairType == null
                                                    ? ''
                                                    : this._repairType.ILART,
                                                this._device == null
                                                    ? ''
                                                    : this._device.EQUNR,
                                                this._position == null
                                                    ? ''
                                                    : this._position.TPLNR,
                                                this._problemDescription == null
                                                    ? ''
                                                    : this
                                                    ._problemDescription
                                                    .CODEGRUPPE,
                                                this._problemDescription == null
                                                    ? ''
                                                    : this
                                                    ._problemDescription
                                                    .CODE,
                                                this._description == null
                                                    ? ''
                                                    : this._description.text,
                                                Global.userInfo == null
                                                    ? ''
                                                    : Global.userInfo.CPLGR,
                                                Global.userInfo == null
                                                    ? ''
                                                    : Global.userInfo.MATYP,
                                                this._isStop ? "O" : "X",
                                                left, (res) {
                                              sapNo = res['QMNUM'];
                                              HttpRequestRest.malfunction(
                                                  left,
                                                  sapNo,
                                                  1,
                                                  pictures,
                                                  video,
                                                  this._problemDescription == null
                                                      ? ''
                                                      : this
                                                      ._problemDescription
                                                      .KURZTEXT_CODE,
                                                  this._description == null
                                                      ? ''
                                                      : this._description.text,
                                                  this._remark == null
                                                      ? ''
                                                      : this._remark.text,
                                                  this._isStop,
                                                  Global.userInfo == null
                                                      ? ''
                                                      : Global.userInfo.PERNR,
                                                  '',
                                                  '',
                                                  '新工单',
                                                  this._position == null
                                                      ? ''
                                                      : this._position.PLTXT,
                                                  this._device == null
                                                      ? ''
                                                      : this._device.EQKTX,
                                                  new DateTime.now().toString(),
                                                  '', (res) {
                                                setState(() {
                                                  this._loading = false;
                                                });
                                                showCupertinoDialog(
                                                    context: widget.rootContext,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CupertinoAlertDialog(
                                                        content: Text(
                                                          "上报成功",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        actions: <Widget>[
                                                          CupertinoDialogAction(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            },
                                                            child: Text("好"),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                                setState(() {
                                                  this._device = null;
                                                  this._repairType = null;
                                                  this._problemDescription = null;
                                                  this._description =
                                                  new TextEditingController();
                                                  this._remark =
                                                  new TextEditingController();
                                                  this._list.value = new List();
                                                });
                                              }, (err) {
                                                setState(() {
                                                  this._loading = false;
                                                });
                                                showCupertinoDialog(
                                                    context: widget.rootContext,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CupertinoAlertDialog(
                                                        content: Text(
                                                          "上报失败",
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        actions: <Widget>[
                                                          CupertinoDialogAction(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            },
                                                            child: Text("好"),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              });
                                            }, (err) {
                                              print(err);
                                              setState(() {
                                                this._loading = false;
                                              });
                                              showCupertinoDialog(
                                                  context: widget.rootContext,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CupertinoAlertDialog(
                                                      content: Text(
                                                        "上报失败",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      actions: <Widget>[
                                                        CupertinoDialogAction(
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Text("好"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            });
                                          }
                                        },
                                        child: Text("是"),
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
