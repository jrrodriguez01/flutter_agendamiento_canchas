import 'dart:convert';

Agenda agendaFromJson(String str) => Agenda.fromJson(json.decode(str));

String agendaToJson(Agenda data) => json.encode(data.toJson());

class Agenda {
  Agenda({
    required this.agendaDetail,
  });
  late final List<AgendaDetail> agendaDetail;

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
    agendaDetail: List<AgendaDetail>.from(json["results"].map((x) => AgendaDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(agendaDetail.map((x) => x.toJson())),
  };

  @override
  String toString(){
    return 'Agenda: {$agendaDetail}';
  }
}

class AgendaDetail{
  AgendaDetail({
    required this.id,
    required this.cancha,
    required this.usuario,
    required this.fecha,
    required this.porcentajeLluvia,
  });

  final String id;
  final String cancha;
  final String usuario;
  final DateTime fecha;
  final int porcentajeLluvia;

  factory AgendaDetail.fromJson(Map<String, dynamic> json) => AgendaDetail(
    id: json["id"] as String,
    cancha: json["cancha"] as String,
    usuario: json["usuario"] as String,
    fecha: DateTime.parse(json["fecha"]),
    porcentajeLluvia: json["porcentajeLluvia"] as int,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cancha": cancha,
    "usuario": usuario,
    "fecha": fecha.toString(),
    "porcentajeLluvia": porcentajeLluvia,
  };

  @override
  String toString(){
    return 'AgendaDetail: {id: $id, cancha: $cancha, usuario: $usuario, fecha: $fecha, porcentajeLluvia: $porcentajeLluvia}';
  }
}