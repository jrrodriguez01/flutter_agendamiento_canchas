
import 'package:intl/intl.dart';

import '../../../domain/model/agenda/agenda.dart';

String? validateInputUsuario(value){
  if (value == null || value.isEmpty) {
    return 'Indicar el nombre de usuario.';
  }else if (value.length < 3){
    return 'Indicar al menos 3 caracteres.';
  }
  return null;
}

valMaxAgendamientoDia(List<AgendaDetail> agenda, String cancha, String fecha){
  bool respuesta = false;
  int cant = 0;
  for (var element in agenda) {
    if(element.cancha == cancha &&
        DateFormat('dd-MM-yyyy').format(element.fecha) == fecha){
      cant++;
    }
  }
  if (cant >= 3){
    respuesta = true;
  }
  return respuesta;
}

String? validateInputCancha(value,List<AgendaDetail> agenda, String comodin, String tipo){
  if (value == null || value.isEmpty) {
    return 'Indicar un valor.';
  }else{
    if (tipo == 'C'){
      if (valMaxAgendamientoDia(agenda, value, comodin)){
        return 'No existe disponibilidad';
      }
    }else{
      if (valMaxAgendamientoDia(agenda, comodin, value)){
        return 'No existe disponibilidad';
      }
    }
  }
  /*else if (valMaxAgendamientoDia(agenda, cancha, fecha)){
    return 'No existe disponibilidad';
  }*/
  return null;
}