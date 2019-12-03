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
import 'package:gztyre/pages/orderCenter/MaterielPage.dart';
import 'package:gztyre/pages/problemReport/DeviceSelectionPage.dart';
import 'package:gztyre/pages/problemReport/ProblemDescriptionPage.dart';
import 'package:gztyre/pages/problemReport/RepairTypePage.dart';
import 'package:gztyre/utils/ListController.dart';

class OrderRepairDetailPage extends StatefulWidget {

  @override
  State createState() {
    return new _OrderRepairDetailPageState();
  }
}

class _OrderRepairDetailPageState extends State<OrderRepairDetailPage> {
  bool _isStop = false;
  TextEditingController _description = TextEditingController();
  ListController _list = ListController(list: []);

  Device _device;
  FunctionPosition _position;
  RepairType _repairType;
  ProblemDescription _problemDescription;

  bool _loading = false;

  _buildTextareaWithPicAndVideoWidget() {
    print({'this.list': this._list.value});
    return TextareaWithPicAndVideoWidget(
      listController: this._list,
      rootContext: context,
      textEditingController: this._description,
      placeholder: "输入维修描述...",
      lines: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        loading: this._loading,
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(94, 102, 111, 1),
            ),
            middle: Text("标题", style: TextStyle(fontWeight: FontWeight.w500)),
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
                          Navigator.of(context).push(
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
                      ListItemWidget(
                        title: Row(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage('assets/images/icon/icon_materiel.png'),
                              color: Color.fromRGBO(10, 65, 150, 1),
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: this._repairType == null
                                  ? Text("领取物料")
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
                          Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return MaterielPage();
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
                              AssetImage(
                                  'assets/images/icon/icon_description.png'),
                              color: Color.fromRGBO(150, 225, 190, 1),
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: this._problemDescription == null
                                  ? Text("故障原因")
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
                          Navigator.of(context).push(
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
