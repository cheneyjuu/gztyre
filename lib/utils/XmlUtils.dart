
import 'package:dio/dio.dart';
import 'package:gztyre/api/model/FunctionPositionWithDevice.dart';
import 'package:gztyre/api/model/Order.dart';
import 'package:gztyre/api/model/ProblemDescription.dart';
import 'package:gztyre/api/model/RepairType.dart';
import 'package:gztyre/api/model/UserInfo.dart';
import 'package:gztyre/api/model/WorkShift.dart';
import 'package:xml/xml.dart' as xml;

class XmlUtils {
  static final XmlUtils _singleton = XmlUtils();

  static XmlUtils getInstance() {
    return _singleton;
  }

//  static Xml2Json myTransformer = Xml2Json();

  static xml.XmlNode buildUserInfoXml(String userId) {
    var builder = new xml.XmlBuilder();
    builder.element("Envelope",
        attributes: {"xmlns": "http://schemas.xmlsoap.org/soap/envelope/"},
        nest: () {
      builder.element("Body", nest: () {
        builder.element("ZpmSearchPernr", attributes: {
          "xmlns": "urn:sap-com:document:sap:soap:functions:mc-style"
        }, nest: () {
          builder.element("EtCplgr", attributes: {"xmlns": ""}, nest: () {
            builder.element("item", nest: () {
              builder.element("Pernr", nest: "");
              builder.element("Cplgr1", nest: "");
              builder.element("Cpltx1", nest: "");
            });
          });
          builder.element("EtMatyp", attributes: {"xmlns": ""}, nest: () {
            builder.element("item", nest: () {
              builder.element("Pernr", nest: "");
              builder.element("Matyp", nest: "");
              builder.element("Matyt", nest: "");
            });
          });
          builder.element("Pernr", attributes: {"xmlns": ""}, nest: userId);
        });
      });
    });
    return builder.build();
  }

  static UserInfo readUserInfoXml(String stringXml) {
    var document = xml.parse(stringXml);
    UserInfo userInfo = new UserInfo();
    userInfo.PERNR = document.findAllElements("Pernr").first.text;
    userInfo.ENAME = document.findAllElements("Ename").first.text;
    userInfo.SORTB = document.findAllElements("Sortb").first.text;
    userInfo.SORTT = document.findAllElements("Sortt").first.text;
    userInfo.CPLGR = document.findAllElements("Cplgr").first.text;
    userInfo.CPLTX = document.findAllElements("Cpltx").first.text;
    userInfo.MATYP = document.findAllElements("Matyp").first.text;
    userInfo.MATYT = document.findAllElements("Matyt").first.text;
    userInfo.WERKS = document.findAllElements("Werks").first.text;
    userInfo.TXTMD = document.findAllElements("Txtmd").first.text;
    userInfo.WCTYPE = document.findAllElements("Wctype").first.text;
    userInfo.M_TYPE = document.findAllElements("MType").first.text;
    return userInfo;
  }

  static xml.XmlNode buildFunctionPositionXml(String PERNR) {
    var builder = new xml.XmlBuilder();
    builder.element("Envelope",
        attributes: {"xmlns": "http://schemas.xmlsoap.org/soap/envelope/"},
        nest: () {
          builder.element("Body", nest: () {
            builder.element("ZpmSearchTplnr", attributes: {
              "xmlns": "urn:sap-com:document:sap:soap:functions:mc-style"
            }, nest: () {
              builder.element("EtData", attributes: {"xmlns": ""}, nest: () {
                builder.element("item", nest: () {
                  builder.element("Tplnr", nest: "");
                  builder.element("Pltxt", nest: "");
                  builder.element("Tplnr2", nest: "");
                  builder.element("Equnr3", nest: "");
                  builder.element("Eqktx3", nest: "");
                  builder.element("Equnr4", nest: "");
                  builder.element("Eqktx4", nest: "");
                  builder.element("Equnr5", nest: "");
                  builder.element("Eqktx5", nest: "");
                });
              });
              builder.element("Pernr", attributes: {"xmlns": ""}, nest: PERNR);
            });
          });
        });
    return builder.build();
  }

  static List<FunctionPositionWithDevice> readFunctionPositionXml(String stringXml) {
    var document = xml.parse(stringXml);
    List<FunctionPositionWithDevice> list = document.findAllElements("item").map((e) {
      FunctionPositionWithDevice functionPositionWithDevice = new FunctionPositionWithDevice();
      functionPositionWithDevice.TPLNR = e.findAllElements("Tplnr").first.text;
      functionPositionWithDevice.PLTXT = e.findAllElements("Pltxt").first.text;
      functionPositionWithDevice.TPLNR2 = e.findAllElements("Tplnr2").first.text;
      functionPositionWithDevice.PLTXT2 = e.findAllElements("Pltxt2").first.text;
      functionPositionWithDevice.EQUNR3 = e.findAllElements("Equnr3").first.text;
      functionPositionWithDevice.EQKTX3 = e.findAllElements("Eqktx3").first.text;
      functionPositionWithDevice.EQUNR4 = e.findAllElements("Equnr4").first.text;
      functionPositionWithDevice.EQKTX4 = e.findAllElements("Eqktx4").first.text;
      functionPositionWithDevice.EQUNR5 = e.findAllElements("Equnr5").first.text;
      functionPositionWithDevice.EQKTX5 = e.findAllElements("Eqktx5").first.text;
      return functionPositionWithDevice;
    }).toList();
    return list;
  }

  static xml.XmlNode buildWorkShiftXml(String PERNR) {
    var builder = new xml.XmlBuilder();
    builder.element("Envelope",
        attributes: {"xmlns": "http://schemas.xmlsoap.org/soap/envelope/"},
        nest: () {
          builder.element("Body", nest: () {
            builder.element("ZpmSearchIngrp", attributes: {
              "xmlns": "urn:sap-com:document:sap:soap:functions:mc-style"
            }, nest: () {
              builder.element("EtData", attributes: {"xmlns": ""}, nest: () {
                builder.element("item", nest: () {
                  builder.element("Ingrp", nest: "");
                  builder.element("Innam", nest: "");
                });
              });
              builder.element("Pernr", attributes: {"xmlns": ""}, nest: PERNR);
            });
          });
        });
    return builder.build();
  }

  static List<WorkShift> readWorkShiftXml(String stringXml) {
    var document = xml.parse(stringXml);
    if (document.findAllElements("MType").first.text == "E") {
      return new List();
    }
    List<WorkShift> list = document.findAllElements("item").map((e) {
      WorkShift workShift = new WorkShift();
      workShift.TPLNR = e.findElements("Ingrp").first.text;
      workShift.PLTXT = e.findElements("Innam").first.text;
      return workShift;
    }).toList();
    return list;
  }

  static xml.XmlNode buildOrderXml(String PERNR, String CPLGR, String MATYP, String SORTB, String WCTYPE, String ASTTX) {
    var builder = new xml.XmlBuilder();
    builder.element("Envelope",
        attributes: {"xmlns": "http://schemas.xmlsoap.org/soap/envelope/"},
        nest: () {
          builder.element("Body", nest: () {
            builder.element("ZpmSearchOrder", attributes: {
              "xmlns": "urn:sap-com:document:sap:soap:functions:mc-style"
            }, nest: () {
              builder.element("IAppData", attributes: {"xmlns": ""}, nest: () {
                  builder.element("Pernr", nest: PERNR);
                  builder.element("Cplgr", nest: CPLGR);
                  builder.element("Matyp", nest: MATYP);
                  builder.element("Sortb", nest: SORTB);
                  builder.element("Wctype", nest: WCTYPE);
                  builder.element("Asttx", nest: ASTTX);
              });
              builder.element("ItOrder", attributes: {"xmlns": ""}, nest: () {
                builder.element("item", nest: () {
                  builder.element("Pernr", nest: "");
                  builder.element("Ktext", nest: "");
                  builder.element("Cpltx", nest: "");
                  builder.element("Qmnum", nest: "");
                  builder.element("Qmtxt", nest: "");
                  builder.element("Pernr1", nest: "");
                  builder.element("Aufnr", nest: "");
                  builder.element("Auftext", nest: "");
                  builder.element("Equnr", nest: "");
                  builder.element("Eqktx", nest: "");
                  builder.element("Tplnr", nest: "");
                  builder.element("Pltxt", nest: "");
                  builder.element("Bautl", nest: "");
                  builder.element("Maktx", nest: "");
                  builder.element("Asttx", nest: "");
                });
              });
            });
          });
        });
    return builder.build();
  }

  static List<Order> readOrderXml(String stringXml) {
    var document = xml.parse(stringXml);
    List<Order> list = document.findAllElements("item").map((e) {
      Order order = new Order();
      order.PERNR = e.findElements("Pernr").first.text;
      order.KTEXT = e.findElements("Ktext").first.text;
      order.CPLTX = e.findElements("Cpltx").first.text;
      order.QMNUM = e.findElements("Qmnum").first.text;
      order.QMTXT = e.findElements("Qmtxt").first.text;
      order.PERNR1 = e.findElements("Pernr1").first.text;
      order.AUFNR = e.findElements("Aufnr").first.text;
      order.AUFTEXT = e.findElements("Auftext").first.text;
      order.EQUNR = e.findElements("Equnr").first.text;
      order.EQKTX = e.findElements("Eqktx").first.text;
      order.TPLNR = e.findElements("Tplnr").first.text;
      order.PLTXT = e.findElements("Pltxt").first.text;
      order.BAUTL = e.findElements("Bautl").first.text;
      order.MAKTX = e.findElements("Maktx").first.text;
      order.ASTTX = e.findElements("Asttx").first.text;
      return order;
    }).toList();
    return list;
  }

  static xml.XmlNode buildRepairTypeXml() {
    var builder = new xml.XmlBuilder();
    builder.element("Envelope",
        attributes: {"xmlns": "http://schemas.xmlsoap.org/soap/envelope/"},
        nest: () {
          builder.element("Body", nest: () {
            builder.element("ZpmSearchIlart", attributes: {
              "xmlns": "urn:sap-com:document:sap:soap:functions:mc-style"
            }, nest: () {
              builder.element("EtData", attributes: {"xmlns": ""}, nest: () {
                builder.element("item", nest: () {
                  builder.element("Ilart", nest: "");
                  builder.element("Ilatx", nest: "");
                });
              });
            });
          });
        });
    return builder.build();
  }

  static List<RepairType> readRepairTypeXml(String stringXml) {
    var document = xml.parse(stringXml);
    try {
      if (document.findAllElements("MType").first.text == "E") {
        return new List();
      }
    } catch (e) {
      print(e);
    }
    List<RepairType> list = document.findAllElements("item").map((e) {
      RepairType repairType = new RepairType();
      repairType.ILART = e.findAllElements("Ilart").first.text;
      repairType.ILATX = e.findAllElements("Ilatx").first.text;
      return repairType;
    }).toList();
    return list;
  }

  static xml.XmlNode buildProblemDescriptionXml(String Katalogart) {
    var builder = new xml.XmlBuilder();
    builder.element("Envelope",
        attributes: {"xmlns": "http://schemas.xmlsoap.org/soap/envelope/"},
        nest: () {
          builder.element("Body", nest: () {
            builder.element("ZpmSearchKatalogart", attributes: {
              "xmlns": "urn:sap-com:document:sap:soap:functions:mc-style"
            }, nest: () {
              builder.element("EtData", attributes: {"xmlns": ""}, nest: () {
                builder.element("item", nest: () {
                  builder.element("Katalogart", nest: "");
                  builder.element("Codegruppe", nest: "");
                  builder.element("Kurztext", nest: "");
                  builder.element("Code", nest: "");
                  builder.element("KurztextCode", nest: "");
                });
              });
              builder.element("Katalogart", attributes: {"xmlns": ""}, nest: Katalogart);
            });
          });
        });
    return builder.build();
  }

  static List<ProblemDescription> readProblemDescriptionXml(String stringXml) {
    var document = xml.parse(stringXml);
      if (document.findAllElements("MType").first.text == "E") {
        return new List();
      }
    List<ProblemDescription> list = document.findAllElements("item").map((e) {
      ProblemDescription problemDescription = new ProblemDescription();
      problemDescription.KATALOGART = e.findAllElements("Katalogart").first.text;
      problemDescription.CODEGRUPPE = e.findAllElements("Codegruppe").first.text;
      problemDescription.KURZTEXT = e.findAllElements("Kurztext").first.text;
      problemDescription.CODE = e.findAllElements("Code").first.text;
      problemDescription.KURZTEXT_CODE = e.findAllElements("KurztextCode").first.text;
      return problemDescription;
    }).toList();
    return list;
  }

  static xml.XmlNode buildReportOrderXml(String PERNR, String INGRP, String ILART, String EQUNR, String TPLNR, String FEGRP,
      String FECOD, String FETXT, String CPLGR, String MATYP, String MSAUS, String APPTRADENO) {
    var builder = new xml.XmlBuilder();
    builder.element("Envelope",
        attributes: {"xmlns": "http://schemas.xmlsoap.org/soap/envelope/"},
        nest: () {
          builder.element("Body", nest: () {
            builder.element("ZpmCreateIw21", attributes: {
              "xmlns": "urn:sap-com:document:sap:soap:functions:mc-style"
            }, nest: () {
              builder.element("EtMessage", attributes: {"xmlns": ""}, nest: () {
                builder.element("item", nest: () {
                  builder.element("Type", nest: "");
                  builder.element("Id", nest: "");
                  builder.element("Number", nest: "");
                  builder.element("Message", nest: "");
                  builder.element("LogNo", nest: "");
                  builder.element("LogMsgNo", nest: "");
                  builder.element("MessageV1", nest: "");
                  builder.element("MessageV2", nest: "");
                  builder.element("MessageV3", nest: "");
                  builder.element("MessageV4", nest: "");
                  builder.element("Parameter", nest: "");
                  builder.element("Row", nest: "");
                  builder.element("Field", nest: "");
                  builder.element("System", nest: "");
                });
              });
              builder.element("IData", attributes: {"xmlns": ""}, nest: () {
                  builder.element("Pernr", nest: PERNR);
                  builder.element("Ingrp", nest: INGRP);
                  builder.element("Ilart", nest: ILART);
                  builder.element("Equnr", nest: EQUNR);
                  builder.element("Tplnr", nest: TPLNR);
                  builder.element("Fegrp", nest: FEGRP);
                  builder.element("Fecod", nest: FECOD);
                  builder.element("Fetxt", nest: FETXT);
                  builder.element("Cplgr", nest: CPLGR);
                  builder.element("Matyp", nest: MATYP);
                  builder.element("Msaus", nest: MSAUS);
                  builder.element("Apptradeno", nest: APPTRADENO);
              });
            });
          });
        });
    return builder.build();
  }

  static Map<String, String> readReportOrderXml(String stringXml) {
    var document = xml.parse(stringXml);
    try {
      if (document.findAllElements("Type").first.text == "E") {
        throw DioError();
      }
    } catch (e) {
      throw DioError();
    }
    Map<String, String> map = new Map();
    map.putIfAbsent("QMNUM", () {
      return document.findAllElements("Qmnum").first.text;
    });
    map.putIfAbsent("WCPLGR", () {
      return document.findAllElements("Wcplgr").first.text;
    });
    map.putIfAbsent("COLORS", () {
      return document.findAllElements("Colors").first.text;
    });
    map.putIfAbsent("WCPLTX", () {
      return document.findAllElements("Wcpltx").first.text;
    });
    map.putIfAbsent("WXFZ", () {
      return document.findAllElements("Wxfz").first.text;
    });
    map.putIfAbsent("TYPE", () {
      return document.findAllElements("Type").first.text;
    });
    return map;
  }
}
