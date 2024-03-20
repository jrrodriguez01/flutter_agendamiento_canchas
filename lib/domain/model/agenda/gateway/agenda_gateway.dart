import '../agenda.dart';
abstract class AgendaGateway {
  Future<List<AgendaDetail>> getAgendas();
  Future<int> getPorcentajeLluvia(String fecha);
}