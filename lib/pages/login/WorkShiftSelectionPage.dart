import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/ListTitleWidget.dart';
import 'package:gztyre/components/SearchBar.dart';
import 'package:gztyre/components/TextButtonWidget.dart';
import 'package:gztyre/main.dart';
import 'package:gztyre/pages/ContainerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkShiftSelectionPage extends StatefulWidget {
  @override
  State createState() => WorkShiftSelectionPageState();
}

class WorkShiftSelectionPageState extends State<WorkShiftSelectionPage> {
  /// todo
  String _selectItem = '';

  List<String> historyList = [
    'K班',
    'G班',
  ];

  List<String> allList = [
    'A班',
    'B班',
    'C班',
    'D班',
    'E班',
    'F班',
    'H班',
    'I班',
    'J班',
    'L班',
    'M班',
    'N班',
    'O班',
    'P班',
  ];

  TextEditingController _shiftController = new TextEditingController();

  Future<String> _get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.get(key);
  }

  _set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  List<Widget> createWidgetList(List<String> list, String position) {
    List<Widget> itemList = [];
    itemList.add(ListTitleWidget(
      title: position,
    ));
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        itemList.add(new GestureDetector(
          child: ListItemSelectWidget(
              title: Text(list[i]),
              item: position + list[i],
              selectedItem: this._selectItem),
          onTap: () {
            this._selectItem = position + list[i];
            setState(() {});
          },
        ));
      } else {
        itemList.add(Divider(
          height: 1,
        ));
        itemList.add(new GestureDetector(
          child: ListItemSelectWidget(
              title: Text(list[i]),
              item: position + list[i],
              selectedItem: this._selectItem),
          onTap: () {
            this._selectItem = position + list[i];
            setState(() {});
          },
        ));
      }
    }
    return itemList;
  }

  @override
  void initState() {
    this._shiftController.addListener(() {
      if (this._shiftController.text == 'a') {
        print(this._selectItem);
        print('a');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
        middle: Text(
          "选择班次",
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        trailing: TextButtonWidget(
          onTap: () async {
            await this._set("token", "12345");
            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) {
              return ContainerPage(rootContext: context,);
            }), (route) {
              return true;
            });
          },
          text: "确定",
        ),
      ),
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      child: SafeArea(
          child: CupertinoScrollbar(
              child: ListView(
        children: <Widget>[
          SearchBar(controller: this._shiftController),
          ...createWidgetList(historyList, "历史选择"),
          ...createWidgetList(allList, "所有班次"),
        ],
      ))),
    );
  }
}
