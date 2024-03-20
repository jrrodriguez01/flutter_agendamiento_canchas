
import '../../../domain/model/cancha/cancha.dart';
import '../../../domain/model/cancha/gateway/cancha_gateway.dart';

class CanchaApi extends CanchaGateway {
  @override
  List<CanchaDetail> getCanchas() {
    CanchaDetail canchaA = CanchaDetail(codigo: 'A', descripcion: 'Cancha A', lat: -34.584219, log: -58.408761, maximaReservaDia: 3);
    CanchaDetail canchaB = CanchaDetail(codigo: 'B', descripcion: 'Cancha B', lat: -34.584219, log: -58.408761, maximaReservaDia: 3);
    CanchaDetail canchaC = CanchaDetail(codigo: 'C', descripcion: 'Cancha C', lat: -34.584219, log: -58.408761, maximaReservaDia: 3);
    List<CanchaDetail> canchaDetail = [];
    canchaDetail.add(canchaA);
    canchaDetail.add(canchaB);
    canchaDetail.add(canchaC);
    return canchaDetail;
  }
}