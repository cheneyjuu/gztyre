import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/utils/XmlUtils.dart';

class HttpRequestRest {
  static Dio http = new Dio(BaseOptions(
//      headers: {"Authorization": "Basic RGV2MDM6MTIzNDU2"},
      baseUrl: "http://139.196.79.230:8080"));

  static upload(List<File> fileList, Function(List list) onSuccess, Function(DioError err) onError) async {
    Map<String, dynamic> map = {"files": fileList};
    FormData formData;
    formData = FormData.fromMap(map);
    try {
      Response response = await http.post(
        "/api/uploadMultipleFiles",
        data: formData,
      );
      onSuccess(response.data);
    } on DioError catch (e) {
      onError(e);
    }
  }

  static download(String fileName, Function(File file) onSuccess,
      Function(DioError err) onError) async {
    try {
      Response response = await http.get("/downloadFile/{fileName:$fileName}");
      onSuccess(response.data);
    } on DioError catch (e) {
      onError(e);
    }
  }

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
      Function(Map map) onSuccess,
      Function(DioError err) onError) async {
    try {
      Response response = await http.post("/api/malfunction", data: {
        "tradeNo": tradeNo,
        "sapNo": sapNo,
        "type": type,
        "pictures": pictures,
        "video": video,
        "desc": desc,
        "addDesc": addDesc,
        "remark": remark,
        "isStop": isStop
      });
      onSuccess(response.data);
    } on DioError catch (e) {
      onError(e);
    }
  }
}
