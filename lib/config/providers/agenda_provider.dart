//import 'package:agendamiento_cancha/domain/usecase/agenda/agenda_use.dart';
//import 'package:agendamiento_cancha/infrastructure/driven_adapter/agenda/agenda_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/agenda/agenda.dart';

enum CanchaFilter { all, canchaA, canchaB, canchaC }

//List<AgendaDetail> _listInit = <AgendaDetail>[];

final canchaFilterProvider = StateProvider<CanchaFilter>((ref) {
  return CanchaFilter.all;
});

/*final getAgendaSave =  Provider<AgendaUseCase>((ref) {
  _listInit = (AgendaUseCase(AgendaApi()).getAllAgendas() as List<AgendaDetail>?)!;
  return  AgendaUseCase(AgendaApi());
});*/

final agendasProvider = StateProvider<List<AgendaDetail>>((ref) {
  return [];
});


final filteredAgendasProvider = Provider<List<AgendaDetail>>((ref) {
  final selectedFilter = ref.watch(canchaFilterProvider);
  final agendas = ref.watch(agendasProvider);
  agendas.sort((a, b) => a.fecha.compareTo(b.fecha));

  switch( selectedFilter ){
    case CanchaFilter.all:
      return agendas;
    case CanchaFilter.canchaA:
      return agendas.where((el) => el.cancha == 'A' ).toList();
    case CanchaFilter.canchaB:
      return agendas.where((el) => el.cancha == 'B' ).toList();
    case CanchaFilter.canchaC:
      return agendas.where((el) => el.cancha == 'C' ).toList();
  }

});