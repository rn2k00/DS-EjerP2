import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

// Clase abstracta de la operación, el modelo
abstract class Operacion {
  double calcular(double num1, double num2);
}

class Suma extends Operacion {
  @override
  double calcular(double num1, double num2) {
    return num1 + num2;
  }
}

class Potencia extends Operacion {
  @override
  double calcular(double num1, double num2) {
    return pow(num1, num2).toDouble();
  }
}

class Multiplicacion extends Operacion {
  @override
  double calcular(double num1, double num2) {
    return num1 * num2;
  }
}

// BLoC para la lógica de la calculadora (Controlador))
class CalculadoraBloc {
  //Clase en Flutter que se utiliza para controlar un campo de texto editable
  late TextEditingController num1Controller;
  late TextEditingController num2Controller;
  late String operacionSeleccionada;
  double resultado = 0.0;

  CalculadoraBloc() {
    num1Controller = TextEditingController();
    num2Controller = TextEditingController();
    operacionSeleccionada = 'Suma';
  }

  void calcularResultado() {
    if (num1Controller.text.isEmpty ||
        num2Controller.text.isEmpty ||
        operacionSeleccionada.isEmpty) {
      resultado = 0.0;
      return;
    }

    double num1 = double.parse(num1Controller.text);
    double num2 = double.parse(num2Controller.text);
    Operacion? operacion;

    switch (operacionSeleccionada) {
      case 'Suma':
        operacion = Suma();
        break;
      case 'Multiplicacion':
        operacion = Multiplicacion();
        break;
      case 'Potencia':
        operacion = Potencia();
        break;
    }

    if (operacion != null) {
      resultado = operacion.calcular(num1, num2);
    } else {
      resultado = 0.0;
    }
  }

  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();
  }
}

//Vista
class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      home: CalculadoraScreen(),
    );
  }
}


class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  late CalculadoraBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CalculadoraBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: bloc.num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Inserte valor 1'),
            ),
            TextField(
              controller: bloc.num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Inserte valor 2'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: bloc.operacionSeleccionada,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                setState(() {
                  bloc.operacionSeleccionada = value!;
                });
              },
              items: ['Suma', 'Multiplicacion', 'Potencia']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  bloc.calcularResultado();
                });
              },
              child: Text('='),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: ${bloc.resultado}',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
