import 'dart:convert';

Cancha canchaFromJson(String str) => Cancha.fromJson(json.decode(str));

String canchaToJson(Cancha data) => json.encode(data.toJson());

class Cancha {
  Cancha({
    required this.canchaDetail,
  });
  final List<CanchaDetail> canchaDetail;

  factory Cancha.fromJson(Map<String, dynamic> json) => Cancha(
    canchaDetail: List<CanchaDetail>.from(json["results"].map((x) => CanchaDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(canchaDetail.map((x) => x.toJson())),
  };
}

class CanchaDetail{
  CanchaDetail({
    required this.codigo,
    required this.descripcion,
    this.lat,
    this.log,
    this.maximaReservaDia,
  });

  final String codigo;
  final String descripcion;
  final double? lat;
  final double? log;
  final int? maximaReservaDia;

  factory CanchaDetail.fromJson(Map<String, dynamic> json) => CanchaDetail(
    codigo: json["codigo"],
    descripcion: json["descripcion"],
    lat: json["lat"],
    log: json["log"],
    maximaReservaDia: json["maximaReservaDia"],
  );

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "descripcion": descripcion,
    "lat": -34.584219,
    "log": -58.408761,
    "maximaReservaDia": 3,
  };

}