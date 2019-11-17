import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemSelectWidget extends StatelessWidget {

  ListItemSelectWidget({Key key, @required this.title, this.height, @required this.item, @required this.selectedItem}) : super(key: key);

  final Text title;
  final double height;
  final String item;
  final String selectedItem;

  final Color _color = Color.fromRGBO(255, 255, 255, 1);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(color: _color),
      height: this.height ?? 50.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: this.title,
            ),
          ),
          this.item == this.selectedItem ? Icon(CupertinoIcons.check_mark, color: Color.fromRGBO(0, 122, 255, 1),) : Container(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }


}
