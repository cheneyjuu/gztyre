class RepairOrder {
  /// 报修人员编码
  String PERNR;

  /// 接单人员名称
  String KTEXT;

  /// 维修区域
  String CPLTX;

  /// 维修工单号
  String AUFNR;

  /// 维修工单名称
  String KTEXT_AUFNR;

  /// 故障描述
  String FETXT;

  /// 设备编码
  String EQUNR;

  /// 设备名称
  String EQKTX;

  /// 功能位置编码
  String TPLNR;

  /// 功能位置名称
  String PLTXT;

  /// 维修工单状态
  String ASTXT;

  /// 报修日期
  String ERDAT;

  /// 报修时间
  String ERTIM;

  /// 是否停机
  bool MSAUS;

  /// 物料列表
  List<Materiel> materielList;

  RepairOrder();

  RepairOrder.formJson(Map<String, dynamic> json)
      : PERNR = json['PERNR'],
        KTEXT = json['KTEXT'],
        CPLTX = json['CPLTX'],
        AUFNR = json['AUFNR'],
        KTEXT_AUFNR = json['KTEXT_AUFNR'],
        FETXT = json["FETXT"],
        EQUNR = json['EQUNR'],
        EQKTX = json['EQKTX'],
        TPLNR = json['TPLNR'],
        PLTXT = json['PLTXT'],
        ASTXT = json["ASTXT"],
        ERDAT = json["ERDAT"],
        ERTIM = json["ERTIM"],
        MSAUS = json["MSAUS"];

  Map<String, dynamic> toJson() => <String, dynamic>{
    "PERNR": PERNR,
    "KTEXT": KTEXT,
    "CPLTX": CPLTX,
    "AUFNR": AUFNR,
    "KTEXT_AUFNR": KTEXT_AUFNR,
    "FETXT": FETXT,
    "EQUNR": EQUNR,
    "EQKTX": EQKTX,
    "TPLNR": TPLNR,
    "PLTXT": PLTXT,
    "ASTXT": ASTXT,
    "ERDAT": ERDAT,
    "ERTIM": ERTIM,
    "MSAUS": MSAUS
  };
}

class Materiel {
  /// 物料编码
  String MATNR;
  /// 物料描述
  String MAKTX;
  /// 领料数量
  String ENMNG;

  Materiel.formJson(Map<String, dynamic> json)
      : MATNR = json['MATNR'],
        MAKTX = json['MAKTX'],
        ENMNG = json['ENMNG'];

  Map<String, dynamic> toJson() => <String, dynamic>{
    "MATNR": MATNR,
    "MAKTX": MAKTX,
    "ENMNG": ENMNG,
  };
}