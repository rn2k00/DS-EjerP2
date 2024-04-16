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

//Clase abastracta de la operacion
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

const List<String> list = <String>['Suma', 'Multiplicacion', 'Potencia'];

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
    //Controlador de los numeros para elacceso y control
  TextEditingController num1Control = TextEditingController();
  TextEditingController num2Control = TextEditingController();
  double resultado = 0.0;
  //Almacena la operación seleccionada y evita que se seleccione nuinguna operacion
  Operacion? operacionSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      //Rellenar al rededor
      body: Padding(
        padding: EdgeInsets.all(65.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            DropdownButtonOperacion(
              onChanged: (Operacion? value) {
                setState(() {
                  operacionSeleccionada = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Resultado: ${calcularResultado()}',
              style: TextStyle(fontSize: 20),
              )
          ],
        ),
      ),
    );
  }
   double calcularResultado() {
    if (num1Control.text.isEmpty ||
        num2Control.text.isEmpty ||
        operacionSeleccionada == null) {
      return 0.0;
    }

    double num1 = double.parse(num1Control.text);
    double num2 = double.parse(num2Control.text);

    return operacionSeleccionada!.calcular(num1, num2);
  }
}

class DropdownButtonOperacion extends StatefulWidget {
  final ValueChanged<Operacion?>? onChanged;

  const DropdownButtonOperacion({Key? key, this.onChanged}) : super(key: key);

  @override
  State<DropdownButtonOperacion> createState() =>
      _DropdownButtonOperacionState();
}

class _DropdownButtonOperacionState extends State<DropdownButtonOperacion> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      //Actualiza el estado del widget y llama a la función de cambio 
      //de selección proporcionada cuando el usuario selecciona un 
      //nuevo valor en el menú desplegable.
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          widget.onChanged?.call(getOperacionFromDropdownValue(value));
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  //mapea un valor de cadena seleccionado en un menú desplegable a 
  //un objeto de operación correspondiente
  Operacion? getOperacionFromDropdownValue(String? value) {
    switch (value) {
      case 'Suma':
        return Suma();
      case 'Multiplicacion':
        return Multiplicacion();
      case 'Potencia':
        return Potencia();
      default:
        return null;
    }
  }
}
