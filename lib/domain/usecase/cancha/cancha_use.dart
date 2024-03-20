import '../../model/cancha/cancha.dart';
import '../../model/cancha/gateway/cancha_gateway.dart';

class CanchaUseCase{
  final CanchaGateway _canchaGateway;
  CanchaUseCase(this._canchaGateway);
  List<CanchaDetail> getAllCanchas() => _canchaGateway.getCanchas();
}