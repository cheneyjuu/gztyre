import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gztyre/components/OrderCardWidget.dart';
import 'package:gztyre/components/UserInfoWidget.dart';
import 'package:gztyre/pages/repairOrder/RepairOrderPage.dart';


class RepairOrderHomePage extends StatelessWidget {
  RepairOrderHomePage({Key key, @required this.rootContext}): assert(rootContext != null), super(key: key);

  final BuildContext rootContext;

  final list = [
    {
      "title": "工单A",
      "level": "1级",
      "status": "已完成",
      "description": "打发打发到发似懂非",
      "position": "炼胶厂",
      "device": "注塑机",
      "isStop": false
    },
    {
      "title": "工单B",
      "level": "1级",
      "status": "维修中",
      "description": "打发打发到发似懂非懂克拉副驾驶登录福建省地方i啦是的就放i啊啥的飞机啊塑料袋封口机反对嘎嘎发的噶地方噶蛋糕阿斯顿发送到发萨噶说噶蛋糕料袋封口机",
      "position": "第一好工厂",
      "device": "注塑机",
      "isStop": false
    },
    {
      "title": "工单C",
      "level": "1级",
      "status": "未完成",
      "description": "打发打发到发似懂非懂克拉副驾驶登录福建省地方i啦是的就放i啊啥的飞机啊塑料袋封口机",
      "position": "炼胶厂",
      "device": "注塑机",
      "isStop": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("我的报修单",style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: UserInfoWidget(),
            ),
            Expanded(
              child:
              CupertinoScrollbar(
                child: ListView.custom(childrenDelegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return new OrderCardWidget(
                      title: list[index]['title'],
                      level: list[index]['level'],
                      status: list[index]['status'],
                      description: list[index]['description'],
                      position: list[index]['position'],
                      device: list[index]['device'],
                      isStop: list[index]['isStop'],
                      onTap: () {
                        Navigator.of(rootContext).push(
                            CupertinoPageRoute(
                                builder: (context) {
                                  return RepairOrderPage();
                                }
                            )
                        );
                      },
                    );
                  },
                  childCount: 3,
                ),
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}