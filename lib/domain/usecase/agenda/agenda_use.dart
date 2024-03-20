import '../../model/agenda/agenda.dart';
import '../../model/agenda/gateway/agenda_gateway.dart';

class AgendaUseCase{
  final AgendaGateway _agendaGateway;
  AgendaUseCase(this._agendaGateway);
  Future<List<AgendaDetail>> getAllAgendas() => _agendaGateway.getAgendas();
}