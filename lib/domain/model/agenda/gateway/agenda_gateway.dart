import '../agenda.dart';
abstract class AgendaGateway {
  Future<List<AgendaDetail>> getAgendas();
}