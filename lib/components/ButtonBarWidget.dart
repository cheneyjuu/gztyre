import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/utils/screen_utils.dart';

class ButtonBarWidget extends StatelessWidget {
  ButtonBarWidget({Key key, this.button}) : super(key: key);

  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: ScreenUtils.screenW(context),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: button,
        ),
      ),
    );
  }
}