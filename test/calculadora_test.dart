import 'package:flutter_test/flutter_test.dart';
import 'package:calcula_chad/main.dart';


void main() {
  group('Tests metodos', () {
    test('Crear objeto Suma', () {
      final operacion = Suma();
      expect(operacion is Suma, true);
    });

    test('Comprobación de cálculo con campos de entrada vacíos', () {
      final bloc = CalculadoraBloc();
      bloc.calcularResultado();
      expect(bloc.resultado, equals(0.0));
    });

    test('Comprobación de cálculo sin operación seleccionada', () {
      final bloc = CalculadoraBloc();
      bloc.num1Controller.text = '10';
      bloc.num2Controller.text = '5';
      bloc.calcularResultado();
      expect(bloc.resultado, equals(0.0));
    });

    test('Comprobación de método calcular en Suma', () {
      final operacion = Suma();
      expect(operacion.calcular(2, 3), equals(5.0));
    });

    test('Comprobación de método calcular en Potencia', () {
      final operacion = Potencia();
      expect(operacion.calcular(2, 3), equals(8.0));
    });

    test('Comprobación de método calcular en Multiplicacion', () {
      final operacion = Multiplicacion();
      expect(operacion.calcular(2, 3), equals(6.0));
    });
  });
}
