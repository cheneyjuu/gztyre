import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequest.dart';
import 'package:gztyre/api/model/ProblemDescription.dart';
import 'package:gztyre/components/ListItemSelectWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/components/TextButtonWidget.dart';

class ProblemDescriptionPage extends StatefulWidget {
  ProblemDescriptionPage({Key key, this.selectItem}) : super(key: key);

  final ProblemDescription selectItem;

  @override
  State createState() => _ProblemDescriptionPageState();
}

class _ProblemDescriptionPageState extends State<ProblemDescriptionPage> {
  ProblemDescription _selectItem;
  bool _loading = false;
  var _listProblemDescriptionFuture;

  List<ProblemDescription> _list = [];

  TextEditingController _searchController = new TextEditingController();

  List<Widget> createWidgetList(List<ProblemDescription> list) {
    List<Widget> itemList = [];
//    itemList.add(ListTitleWidget(
//      title: position,
//    ));
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        itemList.add(new GestureDetector(
          child: ListItemSelectWidget(
              title: Text(
                list[i].KURZTEXT_CODE,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
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
              title: Text(
                list[i].KURZTEXT_CODE,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
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

  _listProblemDescription() {
    this._loading = true;
    HttpRequest.listProblemDescription((List<ProblemDescription> list) {
      this._list = list;
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

  @override
  void initState() {
    this._selectItem = widget.selectItem;
    this._searchController.addListener(() {
      if (this._searchController.text == 'a') {
        print(this._selectItem);
        print('a');
      }
    });
    this._listProblemDescriptionFuture = this._listProblemDescription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: FutureBuilder(
          future: this._listProblemDescriptionFuture,
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
                            ...createWidgetList(this._list),
                          ],
                        ))),
              ),
            );
          },
        ),
        onWillPop: () async {
          Navigator.of(context).pop(this._selectItem);
          return false;
        });
  }
}
