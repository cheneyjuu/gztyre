import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/api/HttpRequestRest.dart';
import 'package:gztyre/components/ListTitleWidget.dart';
import 'package:gztyre/components/ProgressDialog.dart';
import 'package:gztyre/components/ViewDialog.dart';

class RepairDetailPage extends StatefulWidget {



  @override
  State createState() => _RepairDetailPageState();
}

class _RepairDetailPageState extends State<RepairDetailPage> {
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
                    img: {'key': 'test', 'asset': 'assets/images/user.jpeg'},
                    imgs: [
                      {'key': 'test', 'asset': 'assets/images/user.jpeg'},
                      {'key': 'test2', 'asset': 'assets/images/user.jpeg'}
                    ],
                    onlyView: true,
                  )));
        },
      ));
    }
    return list;
  }

//  _getPic() {
//    HttpRequestRest.getMalfunction(tradeNo, onSuccess, onError)
//  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
//      future: ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return new ProgressDialog(
            loading: false,
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  onPressed: () => Navigator.pop(context),
                  color: Color.fromRGBO(94, 102, 111, 1),
                ),
                middle: Text(
                  /// todo
                  "维修详情",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    ListTitleWidget(
                      title: "维修部件",
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        child: Text(
                          "机箱（编码） x 1、电源（编码） x 1、集成主板（编码） x 1、螺丝钉（编码） x 4",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    ListTitleWidget(
                      title: "维修描述",
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 10, right: 10),
                            child: Text(
                              '每拉他更路斯文约设周于教还算照组分还反八标石第从号情战持酸细们问人共么千反但象设目民理合先般放教众严商却记前为还众儿天议备然无叫力候白思利团声种资',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              children: <Widget>[..._buildPic()],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTitleWidget(
                      title: "故障原因",
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 10, right: 10),
                        child: Text(
                          "故障原因故障原因故障原因故障原因故障原因故障原因",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
//        child: Column(
//          children: <Widget>[
//            ListTitleWidget(title: "维修部件",)
//          ],
//        ),
              ),
            ));
      },
    );
  }
}
