import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatefulWidget {

  ListItemWidget({Key key, this.onTap, @required this.title, this.height}) : super(key: key);

  final VoidCallback onTap;
  final Widget title;
  final double height;

  @override
  State createState() {
    return ListItemWidgetState();
  }


}

class ListItemWidgetState extends State<ListItemWidget> {

  Color _color = Color.fromRGBO(255, 255, 255, 1);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (tapDownDetails) {
        this._color = Color.fromRGBO(142, 142, 147, 0.12);
        setState(() {});
      },
      onTapUp: (tapUpDetails) {
        this._color = Color.fromRGBO(255, 255, 255, 1);
        setState(() {});
      },
      onTapCancel: () {
        this._color = Color.fromRGBO(255, 255, 255, 1);
        setState(() {});
      },
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(color: _color),
        height: widget.height ?? 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: widget.title,
              ),
            ),
            Icon(CupertinoIcons.right_chevron, color: Color.fromRGBO(94, 102, 111, 1),),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}