import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/utils/XmlUtils.dart';

class HttpRequestRest {
  static Dio http = new Dio(BaseOptions(
//      headers: {"Authorization": "Basic RGV2MDM6MTIzNDU2"},
      baseUrl: "http://127.0.0.1:8080",
      connectTimeout: 6000));

  static upload(List<dynamic> fileList, Function(List list) onSuccess,
      Function(DioError err) onError) async {
    var formData = new FormData();
    for (int i = 0; i < fileList.length; i++) {
      formData.files
          .add(MapEntry("files", MultipartFile.fromFileSync(fileList[i])));
    }
//  var formData = FormData.fromMap({
//    "file": MultipartFile.fromFileSync(fileList[0])
//  });
    try {
      Response response = await http.post(
        "/api/uploadMultipleFiles",
        data: formData,
      );
      await onSuccess(response.data);
    } on DioError catch (e) {
      await onError(e);
    }
  }

 /// 下载文件
  static download(String fileName, Function(File file) onSuccess,
      Function(DioError err) onError) async {
    try {
      Response response = await http.get("/downloadFile/{fileName:$fileName}");
      await onSuccess(response.data);
    } on DioError catch (e) {
      await onError(e);
    }
  }

  /// 创建工单
  static malfunction(
      String tradeNo,
      String sapNo,
      int type,
      List<String> pictures,
      String video,
      String desc,
      String addDesc,
      String remark,
      bool isStop,
      String userCode,
      String title,
      String level,
      String status,
      String location,
      String device,
      String reportTime,
      String waitTime,
      Function(Map map) onSuccess,
      Function(DioError err) onError) async {
    try {
      Response response = await http.post("/api/malfunction", data: {
        "userCode": userCode,
        "tradeNo": tradeNo,
        "sapNo": sapNo,
        "type": type,
        "pictures": pictures,
        "video": video,
        "desc": desc,
        "addDesc": addDesc,
        "remark": remark,
        "isStop": isStop,
        "title": title,
        "level": level,
        "status": status,
        "location": location,
        "device": device,
        "reportTime": reportTime,
        "waitTime": waitTime
      });
      await onSuccess(response.data);
    } on DioError catch (e) {
      await onError(e);
    }
  }

  /// 查询工单
  static getMalfunction(String sapNo, Function(Map map) onSuccess,
      Function(DioError err) onError) async {
    try {
      Response response = await http.get("/api/malfunction", queryParameters: {
        "sapNo": sapNo
      });
      await onSuccess(response.data["data"]);
    } on DioError catch (e) {
      await onError(e);
    }
  }

  static getOrders(String userCode, Function(List list) onSuccess,
      Function(DioError err) onError) async {
    try {
      Response response = await http.get("/api/malfunction/user/$userCode");
      await onSuccess(response.data['data']);
      print(response.data['data']);
    } on DioError catch (e) {
      await onError(e);
    }
  }
}
