import 'package:agendamiento_cancha/domain/model/agenda/agenda.dart';
import 'package:agendamiento_cancha/ui/pages/helpers/validate_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Testing Validate Input', () {
    test('usuario null', () {
      //Arrange
      const inputValue = '';
      const expectedError = 'Indicar el nombre de usuario.';
      //Act
      final currentValue = validateInputUsuario(inputValue);
      //Assert
      expect(currentValue, expectedError);
    });
    test('tamaño nombre usuario', () {
      //Arrange
      const inputValue = 'ca';
      const expectedError = 'Indicar al menos 3 caracteres.';
      //Act
      final currentValue = validateInputUsuario(inputValue);
      //Assert
      expect(currentValue, expectedError);
    });
    test('nombre usuario correcto', () {
      //Arrange
      const inputValue = 'carlos';
      const expectedError = null;
      //Act
      final currentValue = validateInputUsuario(inputValue);
      //Assert
      expect(currentValue, expectedError);
    });
    test('cancha null', () {
      //Arrange
      const inputValue = '';
      const expectedError = 'Indicar un valor.';
      List<AgendaDetail> agenda = <AgendaDetail>[];
      const comodin = '2024-03-21';
      const tipo = 'C';
      //Act
      final currentValue = validateInputCancha(inputValue, agenda, comodin, tipo);
      //Assert
      expect(currentValue, expectedError);
    });
    test('cancha disponibilidad', () {
      //Arrange
      const inputValue = 'A';
      const expectedError = null;
      List<AgendaDetail> agenda = <AgendaDetail>[];
      const comodin = '2024-03-21';
      const tipo = 'C';
      //Act
      final currentValue = validateInputCancha(inputValue, agenda, comodin, tipo);
      //Assert
      expect(currentValue, expectedError);
    });
  });
}