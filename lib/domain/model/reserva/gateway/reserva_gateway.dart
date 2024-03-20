import '../reserva.dart';
abstract class ReservaDiaGateway {
  Future<List<ReservaDiaDetail>> getReservasDia();
}