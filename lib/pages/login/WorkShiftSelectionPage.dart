import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/model/WorkShift.dart';
import 'package:gztyre/commen/Global.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/ListTitleWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/components/SearchBar.dart';
import 'package:gztyre/components/TextButtonWidget.dart';
import 'package:gztyre/pages/ContainerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkShiftSelectionPage extends StatefulWidget {
  WorkShiftSelectionPage({Key key, this.userName}) : super(key: key);

  final String userName;

  @override
  State createState() => _WorkShiftSelectionPageState();
}

class _WorkShiftSelectionPageState extends State<WorkShiftSelectionPage> {

  WorkShift _selectItem;

  List<WorkShift> _historyList = List();
  List _historyStringList = List();

  List<WorkShift> allList = [];
  List<WorkShift> _tempList = [];

  TextEditingController _shiftController = new TextEditingController();

  Future<String> _get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key);
  }

  _set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  var _listWorkShiftFuture;

  bool _loading = true;

  List<Widget> createWidgetList(List<WorkShift> list, String position) {
    List<Widget> itemList = [];
    if (list.length == 0) {
      return itemList;
    }
    itemList.add(ListTitleWidget(
      title: position,
    ));
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        itemList.add(new GestureDetector(
          child: ListItemSelectWidget(
              title: Text(list[i].PLTXT),
              item: list[i],
              selectedItem: this._selectItem),
          onTap: () {
            this._selectItem = list[i];
            setState(() {});
          },
        ));
      } else {
        itemList.add(Divider(
          height: 1,
        ));
        itemList.add(new GestureDetector(
          child: ListItemSelectWidget(
              title: Text(list[i].PLTXT),
              item: list[i],
              selectedItem: this._selectItem),
          onTap: () {
            this._selectItem = list[i];
            setState(() {});
          },
        ));
      }
    }
    return itemList;
  }

  _listWorkShift() async {
    var string= await Global.prefs.get("historyWorkShift");
    List historyList = jsonDecode(string);
    this._historyStringList = historyList;
    await HttpRequest.listWorkShift(widget.userName, (list) {
      setState(() {
        this._loading = false;
      });
      this.allList = list;
      this._tempList.addAll(list);
      list.forEach((item) {
        historyList.forEach((item2) {
          if (item.TPLNR == item2) {
            this._historyList.add(item);
            this._tempList.remove(item);
          }
        });
      });
      this.allList.clear();
      this.allList.addAll(this._tempList);
//      this._tempList.addAll(list);
      this._selectItem = this._historyList.last;
    }, (err) {
      print(err);
      setState(() {
        this._loading = false;
      });
    });
  }

  @override
  void initState() {
    this._shiftController.addListener(() {
      this.allList = this._tempList.where((item) {
        return item.PLTXT.contains(this._shiftController.text);
      }).toList();
      setState(() {
        // ignore: unnecessary_statements
        this.allList;
      });
      print(this.allList);
    });
    this._listWorkShiftFuture = _listWorkShift();
    if (this._historyList.length > 0) {
      this._selectItem = this._historyList.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _listWorkShiftFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ProgressDialog(
                loading: this._loading,
                child: CupertinoPageScaffold(
                  navigationBar: new CupertinoNavigationBar(
                    leading: CupertinoNavigationBarBackButton(
                      onPressed: () => Navigator.pop(context),
                      color: Color.fromRGBO(94, 102, 111, 1),
                    ),
                    middle: Text(
                      "选择班次",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: TextButtonWidget(
                      onTap: () async {
//            await this._set("token", "12345");
                        Global.workShift = this._selectItem;
                        if (this._selectItem == null) {
                          showCupertinoDialog(
                              context: context,
                              builder: (
                                  BuildContext context) {
                                return CupertinoAlertDialog(
                                  content: Text(
                                    "请选择工作班次",
                                    style:
                                    TextStyle(fontSize: 18),
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
                        } else {
                          this._historyStringList.add(this._selectItem.TPLNR);
                          if (this._historyStringList.length > 5) {
                            this._historyStringList.removeAt(0);
                          }
                          var string = jsonEncode(this._historyStringList.toList());
                          print(string);
                          await Global.prefs.setString("historyWorkShift", jsonEncode(this._historyStringList.toList()));
                          await Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(builder: (BuildContext context) {
                                return ContainerPage(
                                  rootContext: context,
                                );
                              }), (route) {
                            return false;
                          });
                        }
                      },
                      text: "确定",
                    ),
                  ),
                  child: SafeArea(
                      child: CupertinoScrollbar(
                          child: ListView(
                            children: <Widget>[
                              SearchBar(controller: this._shiftController),
                              ...createWidgetList(this._historyList.toList(), "历史选择"),
                              ...createWidgetList(this.allList, "所有班次"),
                            ],
                          ))),
                ),
              );});
  }
}
