import 'package:dio/dio.dart';
import 'package:gztyre/api/model/Device.dart';
import 'package:gztyre/api/model/FunctionPosition.dart';
import 'package:gztyre/api/model/FunctionPositionWithDevice.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/ProblemDescription.dart';
import 'package:gztyre/api/model/RepairType.dart';
import 'package:gztyre/api/model/ReportOrder.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/api/model/WorkShift.dart';
import 'package:gztyre/utils/XmlUtils.dart';

class HttpRequest {
  static Dio http = new Dio(BaseOptions(
    headers: {"Authorization": "Basic RGV2MDM6MTIzNDU2"},
    baseUrl: "http://192.168.6.37:8000/sap/bc/srt/rfc/sap",
    connectTimeout: 6000
  ));


  /// 查询用户信息
  static searchUserInfo(String userId, Function(UserInfo t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildUserInfoXml(userId);
    print(xml);
      try {
        Response response = await http.post("/zpm_search_pernr/888/zpm_search_pernr/zpm_search_pernr",
            data: xml,
            options: Options(contentType: 'text/xml')
        );
        onSuccess(XmlUtils.readUserInfoXml(response.data));
      } on DioError catch(e) {
        onError(e);
      }
  }

  /// 列出位置与设备
  static listPositionAndDevice(String PERNR, Function(List<FunctionPosition> t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildFunctionPositionXml(PERNR);
    print(xml);
    try {
      Response response = await http.post("/zpm_search_tplnr/888/zpm_search_tplnr/zpm_search_tplnr",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      List<FunctionPositionWithDevice> list = XmlUtils.readFunctionPositionXml(response.data);
      List<FunctionPosition> functionPositionList = List();
      List<FunctionPosition> tempFunctionPositionList = List();
      tempFunctionPositionList = list.map((item) {
        FunctionPosition functionPosition = new FunctionPosition();
        functionPosition.childrenDevice = List();
        functionPosition.childrenFunctionPosition = List();
        Device device = new Device();
        device.childrenDevice = List();
        if (item.TPLNR2 != null && item.TPLNR2 != '') {
          functionPosition.TPLNR = item.TPLNR2;
          functionPosition.PLTXT = item.PLTXT2;
        } else {
          functionPosition.TPLNR = item.TPLNR;
          functionPosition.PLTXT = item.PLTXT;
        }
        if (item.EQUNR5 != null && item.EQUNR5 != '') {
          device.EQUNR = item.EQUNR5;
          device.EQKTX = item.EQKTX5;
        } else if (item.EQUNR4 != null && item.EQUNR4 != '') {
          device.EQUNR = item.EQUNR4;
          device.EQKTX = item.EQKTX4;
        } else {
          device.EQUNR = item.EQUNR3;
          device.EQKTX = item.EQKTX3;
        }
        functionPosition.childrenDevice.add(device);
        return functionPosition;
      }).toList();
      tempFunctionPositionList.forEach((item) {
        int index = functionPositionList.indexWhere((item2) {
          return item2.TPLNR == item.TPLNR;
        });
        if (index > -1) {
          functionPositionList[index].childrenDevice.addAll(item.childrenDevice);
        } else {
          functionPositionList.add(item);
        }
      });
      await onSuccess(functionPositionList);
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 列出所有工作中心
  static listWorkShift(String PERNR, Function(List<WorkShift> t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildWorkShiftXml(PERNR);
    print(xml);
    try {
      Response response = await http.post("/zpm_search_ingrp/888/zpm_search_ingrp/zpm_search_ingrp",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      await onSuccess(XmlUtils.readWorkShiftXml(response.data));
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 列出所有工单
  static listOrder(String PERNR, String CPLGR, String MATYP, String SORTB, String WCTYPE, String ASTTX, Function(List<Order> t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildOrderXml(PERNR, CPLGR, MATYP, SORTB, WCTYPE, ASTTX);
    print(xml);
    try {
      Response response = await http.post("/zpm_search_order/888/zpm_search_order/zpm_search_order",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      await onSuccess(XmlUtils.readOrderXml(response.data));
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 报修单详情
  static reportOrderDetail(String QMNUM, Function(ReportOrder t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildReportOrderDetailXml(QMNUM);
    print(xml);
    try {
      Response response = await http.post("/zpm_search_ordermess/888/zpm_search_ordermess/zpm_search_ordermess",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      await onSuccess(XmlUtils.readReportOrderDetailXml(response.data));
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 维修单详情
  static repairOrderDetail(String AUFNR, Function(ReportOrder t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildRepairOrderDetailXml(AUFNR);
    print(xml);
    try {
      Response response = await http.post("/zpm_search_wxrec/888/zpm_search_wxrec/zpm_search_wxrec",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      await onSuccess(XmlUtils.readRepairOrderDetailXml(response.data));
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 列出所有维修类型
  static listRepairType(Function(List<RepairType> t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildRepairTypeXml();
    print(xml);
    try {
      Response response = await http.post("/zpm_search_ilart/888/zpm_search_ilart/zpm_search_ilart",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      await onSuccess(XmlUtils.readRepairTypeXml(response.data));
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 列出所有问题描述
  static listProblemDescription(Function(List<ProblemDescription> t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildProblemDescriptionXml("C");
    print(xml);
    try {
      Response response = await http.post("/zpm_search_katalogart/888/zpm_search_katalogart/zpm_search_katalogart",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      await onSuccess(XmlUtils.readProblemDescriptionXml(response.data));
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 创建通知单
  static createReportOrder(String PERNR, String INGRP, String ILART, String EQUNR, String TPLNR, String FEGRP,
  String FECOD, String FETXT, String CPLGR, String MATYP, String MSAUS, String APPTRADENO, Function(Map<String, String> t) onSuccess, Function(DioError err) onError) async {
    var xml = XmlUtils.buildReportOrderXml(PERNR, INGRP, ILART, EQUNR, TPLNR, FEGRP,
        FECOD, FETXT, CPLGR, MATYP, MSAUS, APPTRADENO);
    print(xml);
    try {
      Response response = await http.post("/zpm_create_iw21/888/zpm_create_iw21/zpm_create_iw21",
          data: xml,
          options: Options(contentType: 'text/xml')
      );
      await onSuccess(XmlUtils.readReportOrderXml(response.data));
    } on DioError catch(e) {
      await onError(e);
    }
  }

  /// 更改工单状态
//  static createReportOrder(String PERNR, String INGRP, String ILART, String EQUNR, String TPLNR, String FEGRP,
//      String FECOD, String FETXT, String CPLGR, String MATYP, String MSAUS, String APPTRADENO, Function(Map<String, String> t) onSuccess, Function(DioError err) onError) async {
//    var xml = XmlUtils.buildReportOrderXml(PERNR, INGRP, ILART, EQUNR, TPLNR, FEGRP,
//        FECOD, FETXT, CPLGR, MATYP, MSAUS, APPTRADENO);
//    print(xml);
//    try {
//      Response response = await http.post("/zpm_create_iw21/888/zpm_create_iw21/zpm_create_iw21",
//          data: xml,
//          options: Options(contentType: 'text/xml')
//      );
//      await onSuccess(XmlUtils.readReportOrderXml(response.data));
//    } on DioError catch(e) {
//      await onError(e);
//    }
//  }

}
