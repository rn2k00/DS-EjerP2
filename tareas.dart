import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(AppGestorTareas());
}

class Tarea {
  String descripcion;
  bool completada;

  Tarea(this.descripcion, this.completada);
}

class BlocTareas {
  final _controladorTareas = StreamController<List<Tarea>>.broadcast();

  List<Tarea> _tareas = [];

  Stream<List<Tarea>> get flujoTareas => _controladorTareas.stream;

  void dispose() {
    _controladorTareas.close();
  }

  void agregarTarea(Tarea tarea) {
    _tareas.add(tarea);
    _controladorTareas.add(_tareas);
  }

  void alternarTarea(int indice) {
    _tareas[indice].completada = !_tareas[indice].completada;
    _controladorTareas.add(_tareas);
  }

  void eliminarTarea(int indice) {
    _tareas.removeAt(indice);
    _controladorTareas.add(_tareas);
  }
}

class AppGestorTareas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PantallaGestorTareas(),
    );
  }
}

class PantallaGestorTareas extends StatefulWidget {
  @override
  _PantallaGestorTareasState createState() => _PantallaGestorTareasState();
}

class _PantallaGestorTareasState extends State<PantallaGestorTareas> {
  final _bloc = BlocTareas();
  final TextEditingController _controladorTarea = TextEditingController();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestor de Tareas'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controladorTarea,
                    decoration: InputDecoration(
                      labelText: 'Agregar una nueva tarea',
                    ),
                    onSubmitted: (valor) {
                      _bloc.agregarTarea(Tarea(valor, false));
                      _controladorTarea.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _bloc.agregarTarea(Tarea(_controladorTarea.text, false));
                    _controladorTarea.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Tarea>>(
              stream: _bloc.flujoTareas,
              initialData: [],
              builder: (context, snapshot) {
                final tareas = snapshot.data;
                if (tareas != null) {
                  return ListView.builder(
                    itemCount: tareas.length,
                    itemBuilder: (context, indice) {
                      return ItemTarea(
                        tarea: tareas[indice],
                        alAlternar: () => _bloc.alternarTarea(indice),
                        alEliminar: () => _bloc.eliminarTarea(indice),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemTarea extends StatelessWidget {
  final Tarea tarea;
  final VoidCallback alAlternar;
  final VoidCallback alEliminar;

  ItemTarea({required this.tarea, required this.alAlternar, required this.alEliminar});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        tarea.descripcion,
        style: TextStyle(
          decoration: tarea.completada ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => alEliminar(),
          ),
        ],
      ),
      onTap: () => alAlternar(),
      leading: Checkbox(
        value: tarea.completada,
        onChanged: (valor) => alAlternar(),
      ),
    );
  }
}
