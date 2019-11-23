import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/TextButtonWidget.dart';

class ProblemDescriptionPage extends StatefulWidget {
  ProblemDescriptionPage({Key key, this.selectItem}) : super(key: key);

  final String selectItem;

  @override
  State createState() => _ProblemDescriptionPageState();
}

class _ProblemDescriptionPageState extends State<ProblemDescriptionPage> {

  String _selectItem = '';

  List<String> posA = [
    '描述A',
    '描述B',
    '描述C',
    '描述D',
    '描述E',
    '描述F',
    '描述G',
    '描述H'
  ];

  TextEditingController _shiftController = new TextEditingController();

  List<Widget> createWidgetList(List<String> list) {
    List<Widget> itemList = [];
//    itemList.add(ListTitleWidget(
//      title: position,
//    ));
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        itemList.add(new GestureDetector(
          child: ListItemSelectWidget(
              title: Text(list[i], overflow: TextOverflow.ellipsis, maxLines: 1,),
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
              title: Text(list[i], overflow: TextOverflow.ellipsis, maxLines: 1,),
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
    return new WillPopScope(child: CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(widget.selectItem),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
        middle: Text(
          "故障描述",
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
                  ...createWidgetList(posA),
                ],
              ))),
    ), onWillPop: () async {
      Navigator.of(context).pop(this._selectItem);
      return false;
    });
  }
}
