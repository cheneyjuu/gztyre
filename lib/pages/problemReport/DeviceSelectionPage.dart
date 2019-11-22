import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/ListTitleWidget.dart';
import 'package:gztyre/components/SearchBar.dart';
import 'package:gztyre/components/TextButtonWidget.dart';

class DeviceSelectionPage extends StatefulWidget {
  DeviceSelectionPage({Key key, @required this.selectItem}) : super(key: key);

  final String selectItem;

  @override
  State createState() => _DeviceSelectionPageState();
}

class _DeviceSelectionPageState extends State<DeviceSelectionPage> {

  String _selectItem = '';

  List<String> posA = [
    'Sandra Adams 1',
    'Sandra Adams 2',
  ];

  List<String> posB = [
    'Sandra Adams 3',
    'Sandra Adams 4',
  ];

  List<String> posC = [
    'Sandra Adams 5',
    'Sandra Adams 6',
    'Sandra Adams 7',
    'Sandra Adams 8',
    'Sandra Adams 9',
    'Sandra Adams 10',
  ];

  TextEditingController _shiftController = new TextEditingController();

  List<Widget> search(String keyword) {

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
              item: list[i],
              selectedItem: this._selectItem),
          onTap: () {
            if (this._selectItem == list[i]) {
              this._selectItem = '';
            } else this._selectItem = list[i];
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
              item: list[i],
              selectedItem: this._selectItem),
          onTap: () {
            if (this._selectItem == list[i]) {
              this._selectItem = '';
            } else this._selectItem = list[i];
            setState(() {});
          },
        ));
      }
    }
    return itemList;
  }

  @override
  void initState() {
    this._selectItem = widget.selectItem;
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
          onPressed: () => Navigator.of(context).pop(widget.selectItem),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
        middle: Text(
          "选择设备",
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
                  SearchBar(controller: this._shiftController),
                  ...createWidgetList(posA, "位置A"),
                  ...createWidgetList(posB, "位置B"),
                  ...createWidgetList(posC, "位置C"),
                ],
              ))),
    );
  }
}
