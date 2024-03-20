import '../../model/reserva/gateway/reserva_gateway.dart';
import '../../model/reserva/reserva.dart';

class ReservaDiaUseCase{
  final ReservaDiaGateway _reservaDiaGateway;
  ReservaDiaUseCase(this._reservaDiaGateway);
  Future<List<ReservaDiaDetail>> getAllReservasDia() => _reservaDiaGateway.getReservasDia();
}