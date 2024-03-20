import 'package:agendamiento_cancha/ui/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fakeApp = ProviderScope(
  child: MaterialApp(
    home: const AgendaPage(),
    routes: {
      'home': (context) => const Scaffold()
    },
  ),
);
void main(){
  group('Encontrar todos los widgets en pantalla', () {
    testWidgets('Encontrar titulo', (widgetTester) async{
      await widgetTester.pumpWidget(fakeApp);

      const title = 'Agendar cancha';
      final findTitle = find.text(title);
      expect(findTitle, findsOneWidget);
    });
    testWidgets('Encontrar input usuario por key', (widgetTester) async{
      await widgetTester.pumpWidget(fakeApp);

      const inputNameKey = Key('input-usuario');
      final findKey = find.byKey(inputNameKey);
      expect(findKey, findsOneWidget);
    });
    testWidgets('Encontrar button agendar por type', (widgetTester) async{
      await widgetTester.pumpWidget(fakeApp);

      final findButton = find.byType(ElevatedButton);
      expect(findButton, findsOneWidget);
    });
  });

  group('Ser capaz de interactuar con los widgets en pantalla', () {
    testWidgets('llenar el nombre de usuario', (widgetTester) async{
      await widgetTester.pumpWidget(fakeApp);
      const name = 'Leonardo';
      const inputNameKey = Key('input-usuario');
      final findKey = find.byKey(inputNameKey);

      await widgetTester.enterText(findKey, name);
      await widgetTester.pump();

      final findedUserName = find.text(name);
      expect(findedUserName, findsOneWidget);
    });
  });

  group('Probar la interaccion del usuario con los widgets', () {
    testWidgets('no lleno ningun campo y doy click en el boton de crear agendamiento', (widgetTester) async{
      await widgetTester.pumpWidget(fakeApp);
      const expectError = 'Indicar un valor.';

      final findButton = find.byType(ElevatedButton);
      await widgetTester.tap(findButton);
      await widgetTester.pump();

      final findedError = find.text(expectError);
      expect(findedError, findsAtLeastNWidgets(2));
    });
  });
}