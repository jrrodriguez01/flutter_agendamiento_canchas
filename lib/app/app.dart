import 'package:flutter/material.dart';

import '../config/routes/app_routes.dart';
import '../ui/pages.dart';

class MiAgenda extends StatelessWidget {
  const MiAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (routeSetting){
          switch (routeSetting.name) {
            case AppRoutes.agenda:
              return MaterialPageRoute(builder: (context) => const AgendaPage());
            default:
              return MaterialPageRoute(builder: (context) => const HomePage());
          }
        }
    );
  }
}
