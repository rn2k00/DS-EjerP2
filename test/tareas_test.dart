import 'package:flutter_test/flutter_test.dart';
import 'package:tareas_god/main.dart';

void main() {
  group('GestorDeTareas', () {
    late GestorDeTareas gestor;

    setUp(() {
      gestor = GestorDeTareas();
    });

    test('Constructor sin tareas', () {
      expect(gestor.tareas, isEmpty);
    });

    test('Agregar tarea', () {
      gestor.agregarTarea('Nueva tarea');
      expect(gestor.tareas.length, equals(1));
      expect(gestor.tareas[0].descripcion, equals('Nueva tarea'));
      expect(gestor.tareas[0].completada, isFalse);
    });

    test('Eliminar tarea', () {
      gestor.agregarTarea('Tarea a eliminar');
      expect(gestor.tareas.length, equals(1));
      gestor.eliminarTarea(0);
      expect(gestor.tareas, isEmpty);
    });

    test('Eliminar tarea inexistente', () {
      gestor.agregarTarea('Tarea 1');
      expect(() => gestor.eliminarTarea(1), throwsRangeError);
      expect(gestor.tareas.length, equals(1));
    });

    test('Marcar tarea como completada', () {
      gestor.agregarTarea('Tarea a completar');
      gestor.marcarTareaComoCompletada(0);
      expect(gestor.tareas[0].completada, isTrue);
    });

    test('Marcar tarea como completada inexistente', () {
      gestor.agregarTarea('Tarea 1');
      expect(() => gestor.marcarTareaComoCompletada(1), throwsRangeError);
      expect(gestor.tareas[0].completada, isFalse);
    });

    test('Marcar tarea como no completada después de completada', () {
      gestor.agregarTarea('Tarea 1');
      gestor.marcarTareaComoCompletada(0);
      expect(gestor.tareas[0].completada, isTrue);

      gestor.marcarTareaComoCompletada(0);
      expect(gestor.tareas[0].completada, isFalse);
    });
  });
}
