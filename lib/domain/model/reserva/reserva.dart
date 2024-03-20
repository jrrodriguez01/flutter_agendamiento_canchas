import 'dart:convert';

ReservaDia reservaDiaFromJson(String str) => ReservaDia.fromJson(json.decode(str));

String reservaDiaToJson(ReservaDia data) => json.encode(data.toJson());

class ReservaDia {
  ReservaDia({
    required this.reservaDiaDetail,
  });
  final List<ReservaDiaDetail> reservaDiaDetail;

  factory ReservaDia.fromJson(Map<String, dynamic> json) => ReservaDia(
    reservaDiaDetail: List<ReservaDiaDetail>.from(json["results"].map((x) => ReservaDiaDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(reservaDiaDetail.map((x) => x.toJson())),
  };
}

class ReservaDiaDetail{
  ReservaDiaDetail({
    required this.cancha,
    required this.fecha,
    required this.cantidad,
  });

  final String cancha;
  final DateTime fecha;
  final int cantidad;

  factory ReservaDiaDetail.fromJson(Map<String, dynamic> json) => ReservaDiaDetail(
    cancha: json["cancha"],
    fecha: json["fecha"],
    cantidad: json["cantidad"],
  );

  Map<String, dynamic> toJson() => {
    "cancha": cancha,
    "fecha": fecha,
    "cantidad": cantidad,
  };

}