
import 'dart:convert';

import 'package:agendamiento_cancha/domain/model/agenda/agenda.dart';
import '../../../domain/model/agenda/gateway/agenda_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgendaApi extends AgendaGateway {
  @override
  Future<List<AgendaDetail>> getAgendas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    String? listAgendaSaved = prefs.getString('lAgenda');
    List<AgendaDetail>? listAgendaTransf;
    if (listAgendaSaved != null && listAgendaSaved != ''){
      Map<String, dynamic> listaMap = jsonDecode(listAgendaSaved);
      Agenda datos = Agenda.fromJson(listaMap);
      listAgendaTransf = datos.agendaDetail;
    }else{
      listAgendaTransf = <AgendaDetail>[];
    }

    return listAgendaTransf;
  }
}