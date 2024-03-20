import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecase/cancha/cancha_use.dart';
import '../../infrastructure/driven_adapter/cancha/cancha_api.dart';

final canchaProvider = Provider<CanchaUseCase>((ref) {
  return  CanchaUseCase(CanchaApi());
});
