import 'package:flutter/material.dart';

// Modelo
class Tarea {
  String descripcion;
  bool completada;

  Tarea(this.descripcion, this.completada);
}

// Controlador
class GestorDeTareas {
  List<Tarea> _tareas = [];

  List<Tarea> get tareas => _tareas;

  void agregarTarea(String descripcion) {
    _tareas.add(Tarea(descripcion, false));
  }

  // Método para eliminar una tarea en el índice proporcionado
  void eliminarTarea(int index) {
    _tareas.removeAt(index);
  }

  void marcarTareaComoCompletada(int index) {
    _tareas[index].completada = !_tareas[index].completada;
  }
}

// Vista
class ListaDeTareas extends StatefulWidget {
  @override
  _ListaDeTareasState createState() => _ListaDeTareasState();
}

class _ListaDeTareasState extends State<ListaDeTareas> {
  final _gestorDeTareas = GestorDeTareas();
  final _controladorDescripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(60.0),
        child: Column(
          children: [
            // TextField para ingresar la descripción de la tarea
            TextField(
              controller: _controladorDescripcion,
              decoration: InputDecoration(
                labelText: 'Descripción de la Tarea',
              ),
              onSubmitted: (value) {
                _agregarTarea(value);
              },
            ),
            SizedBox(height: 20),
            // Botón para agregar la tarea
            ElevatedButton(
              onPressed: () {
                _agregarTarea(_controladorDescripcion.text);
              },
              child: Text('Agregar Tarea'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _gestorDeTareas.tareas.length,
                itemBuilder: (context, index) {
                  final tarea = _gestorDeTareas.tareas[index];
                  return Dismissible(
                    key: Key(tarea.descripcion),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Método llamado cuando se completa el deslizamiento para eliminar la tarea
                    onDismissed: (direction) {
                      _gestorDeTareas.eliminarTarea(index);
                      setState(() {});
                    },
                    child: ListTile(
                      title: Text(tarea.descripcion),
                      // Checkbox para marcar la tarea como completada
                      trailing: Checkbox(
                        value: tarea.completada,
                        onChanged: (value) {
                          setState(() {
                            _gestorDeTareas.marcarTareaComoCompletada(index);
                          });
                        },
                      ),
                      // Cambiar el color del título si la tarea está completada
                      tileColor: tarea.completada ? Colors.grey[300] : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para agregar una nueva tarea
  void _agregarTarea(String descripcion) {
    if (descripcion.isNotEmpty) {
      setState(() {
        _gestorDeTareas.agregarTarea(descripcion);
        _controladorDescripcion.clear();
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ListaDeTareas(),
  ));
}
