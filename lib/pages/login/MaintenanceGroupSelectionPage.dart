import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ListItemWidget.dart';

class MaintenanceGroupSelectionPage extends StatelessWidget {

  final List<String> list = [
    '跟班维修',
    '常早班维修',
    '工装维修'
  ];

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
        middle: Text("选择维修分组", style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      child: SafeArea(
          child: CupertinoScrollbar(
            child: ListView.custom(childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index % 2 == 0) {
                    return ListItemWidget(title: Text(list[index ~/ 2]),);
                  } else return Divider(height: 1,);
                },
              childCount: list.length * 2 -1
            )),
          )
      ),
    );
  }
}