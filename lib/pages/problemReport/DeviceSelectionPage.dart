import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/model/Device.dart';
import 'package:gztyre/api/model/FunctionPosition.dart';
import 'package:gztyre/commen/Global.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/ListTitleWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/components/SearchBar.dart';
import 'package:gztyre/components/TextButtonWidget.dart';

class DeviceSelectionPage extends StatefulWidget {
  DeviceSelectionPage({Key key, @required this.selectItem}) : super(key: key);

  final Device selectItem;

  @override
  State createState() => _DeviceSelectionPageState();
}

class _DeviceSelectionPageState extends State<DeviceSelectionPage> {
  Device _selectItem;
  FunctionPosition _selectPosition;

  bool _loading = false;

  List<FunctionPosition> _postion = [];
  List<FunctionPosition> _tempPostion = [];

  var _listPositionAndDeviceFuture;

  TextEditingController _shiftController = new TextEditingController();

//  List<Widget> search(String keyword) {}

  _listPositionAndDevice() async {
    this._loading = true;
    HttpRequest.listPositionAndDevice(Global.userInfo.PERNR,
            (List<FunctionPosition> list) {
          print(list);
          this._postion = list;
          this._tempPostion.addAll(list);
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

  List<Widget> createWidgetList(List<FunctionPosition> list) {
    List<Widget> positionList = [];
    list.forEach((position) {
      List<Widget> itemList = [];
      itemList.add(ListTitleWidget(
        title: position.PLTXT,
      ));
      for (int i = 0; i < position.childrenDevice.length; i++) {
        if (i == 0) {
          itemList.add(new GestureDetector(
            child: ListItemSelectWidget(
                title: Text(position.childrenDevice[i].EQKTX),
                item: position.childrenDevice[i],
                selectedItem: this._selectItem),
            onTap: () {
              if (this._selectItem == position.childrenDevice[i]) {
                this._selectItem = null;
              } else
                this._selectItem = position.childrenDevice[i];
              setState(() {});
            },
          ));
        } else {
          itemList.add(Divider(
            height: 1,
          ));
          itemList.add(new GestureDetector(
            child: ListItemSelectWidget(
                title: Text(position.childrenDevice[i].EQKTX),
                item: position.childrenDevice[i],
                selectedItem: this._selectItem),
            onTap: () {
              if (this._selectItem == position.childrenDevice[i]) {
                this._selectItem = null;
              } else
                this._selectItem = position.childrenDevice[i];
              setState(() {});
            },
          ));
        }
      }
      positionList.addAll(itemList);
    });
    return positionList;
  }

  @override
  void initState() {
    this._selectItem = widget.selectItem;
    this._shiftController.addListener(() {
      this._postion = this._tempPostion.where((item) {
        return item.childrenDevice.any((item2) {
          return item2.EQKTX.contains(this._shiftController.text);
        });
      }).toList();
      setState(() {
        // ignore: unnecessary_statements
        this._postion;
      });
    });
    this._listPositionAndDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: FutureBuilder(
          future: _listPositionAndDeviceFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ProgressDialog(
                  loading: this._loading,
                  child: CupertinoPageScaffold(
                    navigationBar: new CupertinoNavigationBar(
                      leading: CupertinoNavigationBarBackButton(
                        onPressed: () {
                          Navigator.of(context).pop(widget.selectItem);
                        },
                        color: Color.fromRGBO(94, 102, 111, 1),
                      ),
                      middle: Text(
                        "选择设备",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: TextButtonWidget(
                        onTap: () {
                          this._postion.forEach((item) {
                            if (item.childrenDevice.contains(this._selectItem)) {
                              this._selectPosition = item;
                            }
                          });
                          Navigator.of(context).pop({'device': this._selectItem, 'pos': this._selectPosition});
                        },
                        text: "确定",
                      ),
                    ),
                    child: SafeArea(
                        child: CupertinoScrollbar(
                            child: ListView(
                              children: <Widget>[
                                SearchBar(controller: this._shiftController),
                                ...createWidgetList(this._postion),
                              ],
                            ))),
                  ));
            }),
        onWillPop: () async {
          Navigator.of(context).pop(this._selectItem);
          return false;
        });
  }
}
