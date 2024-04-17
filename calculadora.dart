import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      home: CalculadoraScreen(),
    );
  }
}

// Clase abstracta de la operación
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

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  //Controlador de los numeros para elacceso y control
  TextEditingController num1Control = TextEditingController();
  TextEditingController num2Control = TextEditingController();
  double resultado = 0.0;
  //Operacion seleccionada por defecto
  String operacionSeleccionada = 'Suma';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      //Rellenamos al rededor con espacios en blanco
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: num1Control,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Inserte valor 1'),
            ),
            TextField(
              controller: num2Control,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Inserte valor 2'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: operacionSeleccionada,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                setState(() {
                  operacionSeleccionada = value!;
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
                  resultado = calcularResultado();
                });
              },
              child: Text('='),
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: $resultado',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  double calcularResultado() {
    if (num1Control.text.isEmpty ||
        num2Control.text.isEmpty ||
        operacionSeleccionada.isEmpty) {
      return 0.0;
    }

    double num1 = double.parse(num1Control.text);
    double num2 = double.parse(num2Control.text);
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
      return operacion.calcular(num1, num2);
    } else {
      return 0.0;
    }
  }
}
