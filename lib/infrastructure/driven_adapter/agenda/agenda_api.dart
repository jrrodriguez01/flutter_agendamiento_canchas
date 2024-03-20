
import 'dart:convert';

import 'package:agendamiento_cancha/domain/model/agenda/agenda.dart';
import '../../../domain/model/agenda/gateway/agenda_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  @override
  Future<int> getPorcentajeLluvia(String fecha) async {
    int porcentaje = 0;
    Uri url = Uri.parse('https://my.meteoblue.com/packages/basic-1h_basic-day_clouds-day?apikey=dI473u0XmKTHcazZ&lat=-34.584219242027416&lon=-58.40876103028817&asl=25&format=json');
    final response = await http.get(url);
    if(response.statusCode == 200 ){
      final Map parsed = json.decode(response.body);
      final datosDia = parsed["data_day"];
      final dias = datosDia["time"];
      int posicion = 0;
      for (var el in dias) {
        if(el == fecha) {
          break;
        }
        posicion++;
      }
      final probabilidad = datosDia["precipitation_probability"];
      int idxProba = 0;
      for (var el in probabilidad) {
        if(idxProba == posicion){
          porcentaje = el;
          break;
        }
        idxProba++;
      }
    }

    return porcentaje;
  }
}