import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/ViewDialog.dart';

class RepairOrderDetailPage extends StatefulWidget {
  @override
  State createState() => RepairOrderDetailPageState();
}

class RepairOrderDetailPageState extends State<RepairOrderDetailPage> {
  List<Widget> _buildPic() {
    List<Widget> list = [];
    for (int i = 0; i < 2; i++) {
      list.add(GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Image.asset('assets/images/user.jpeg'),
        ),
        onTap: () {
          Navigator.of(context).push(new CupertinoPageRoute(
              builder: (context) => new ViewDialog(
                    img: {'key': 'test', 'file': 'assets/images/user.jpeg'},
                imgs: [{'key': 'test', 'file': 'assets/images/user.jpeg'},{'key': 'test2', 'file': 'assets/images/user.jpeg'}],
                  onlyView: true,)));
        },
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(94, 102, 111, 1),
        ),
        middle: Text(
          /// todo
          "工单详情",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
              child: Text(
                '每拉他更路斯文约设周于教还算照组分还反八标石第从号情战持酸细们问人共么千反但象设目民理合先般放教众严商却记前为还众儿天议备然无叫力候白思利团声种资',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[..._buildPic()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
