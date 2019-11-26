import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/model/RepairType.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/ListItemWidget.dart';
import 'package:gztyre/components/ListTitleWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/components/SearchBar.dart';
import 'package:gztyre/components/TextButtonWidget.dart';

class RepairTypePage extends StatefulWidget {
  RepairTypePage({Key key, @required this.selectItem}) : super(key: key);

  final RepairType selectItem;

  @override
  State createState() => _RepairTypePageState();
}

class _RepairTypePageState extends State<RepairTypePage> {
  /// todo
  RepairType _selectItem = RepairType();

  bool _loading = false;

  List<RepairType> _repairType = [];

  TextEditingController _shiftController = new TextEditingController();

  var _listRepairTypeFuture;

  _listRepairType() async {
    setState(() {
      this._loading = true;
    });
    HttpRequest.listRepairType((List<RepairType> list) {
      this._repairType = list;
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

  List<Widget> createWidgetList(List<RepairType> list) {
    List<Widget> itemList = [];
//    itemList.add(ListTitleWidget(
//      title: position,
//    ));
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        itemList.add(new GestureDetector(
          child: ListItemSelectWidget(
              title: Text(list[i].ILATX),
              item: list[i],
              selectedItem: this._selectItem),
          onTap: () {
            if (this._selectItem == list[i]) {
              this._selectItem = null;
            } else
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
              title: Text(list[i].ILATX),
              item: list[i],
              selectedItem: this._selectItem),
          onTap: () {
            if (this._selectItem == list[i]) {
              this._selectItem = null;
            } else
              this._selectItem = list[i];
            setState(() {});
          },
        ));
      }
    }
    return itemList;
  }

  @override
  void initState() {
    this._listRepairTypeFuture = _listRepairType();
    this._selectItem = widget.selectItem;
    this._shiftController.addListener(() {
      if (this._shiftController.text == 'a') {
        print(this._selectItem);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: FutureBuilder(
            future: _listRepairTypeFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ProgressDialog(
                loading: this._loading,
                child: CupertinoPageScaffold(
                  navigationBar: new CupertinoNavigationBar(
                    leading: CupertinoNavigationBarBackButton(
                      onPressed: () =>
                          Navigator.of(context).pop(widget.selectItem),
                      color: Color.fromRGBO(94, 102, 111, 1),
                    ),
                    middle: Text(
                      "维修类型",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: TextButtonWidget(
                      onTap: () {
                        Navigator.of(context).pop(this._selectItem);
                      },
                      text: "确定",
                    ),
                  ),
                  child: SafeArea(
                      child: CupertinoScrollbar(
                          child: ListView(
                    children: <Widget>[
//                  SearchBar(controller: this._shiftController),
                      ...createWidgetList(_repairType),
                    ],
                  ))),
                ),
              );
            }),
        onWillPop: () async {
          Navigator.of(context).pop(this._selectItem);
          return false;
        });
  }
}
