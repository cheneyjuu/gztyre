import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/TextButtonWidget.dart';

class ProblemDescriptionPage extends StatefulWidget {
  ProblemDescriptionPage({Key key, this.selectItem}) : super(key: key);

  final String selectItem;

  @override
  State createState() => ProblemDescriptionPageState();
}

class ProblemDescriptionPageState extends State<ProblemDescriptionPage> {

  String _selectItem = '';

  List<String> posA = [
    '描述A',
    '描述B',
    '阿读书噶滴洒苏打粉萨噶蛋糕',
    '阿斯顿嘎是滴噶蛋糕',
    'asdfasgasdg阿斯顿嘎的时光',
    'asdfasgasdg阿斯顿嘎的时asfasfasf光',
    'asdfasgasdg阿斯顿嘎的asdfasdfasdf时光',
    'asdfasgasdg阿斯顿嘎是滴噶滴噶蛋糕上的还是发货发货的凤凰山的时光'
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
    return new CupertinoPageScaffold(
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
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      child: SafeArea(
          child: CupertinoScrollbar(
              child: ListView(
                children: <Widget>[
//                  SearchBar(controller: this._shiftController),
                  ...createWidgetList(posA),
                ],
              ))),
    );
  }
}
