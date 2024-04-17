import 'package:flutter/material.dart';

// Definición de la clase abstracta PizzaBuilder
abstract class PizzaBuilder {
  Pizza pizza = Pizza();

  void createNewPizza();
  void addIngredientes();
  void addSalsa();
  void tipoMasa();
  void tamanoPizza();
}

// Definición de la clase abstracta BocataBuilder
abstract class BocataBuilder {
  Bocata bocata = Bocata();

  void createNewBocata();
  void addIngredientes();
  void tipoPan();
  void tamanoBocata();
}

// Implementación de las subclases de PizzaBuilder

class BBQPizzaBuilder extends PizzaBuilder {
  @override
  void createNewPizza() {
    pizza = Pizza();
  }

  @override
  void addIngredientes() {
    pizza.ingredientes = ['salsa barbacoa', 'queso', 'cebolla', 'pollo', 'maíz'];
  }

  @override
  void addSalsa() {
    pizza.salsa = 'barbacoa';
  }

  @override
  void tipoMasa() {
    pizza.tipoMasa = 'tradicional';
  }

  @override
  void tamanoPizza() {
    pizza.tamano = 'mediano';
  }
}

// Implementación de las subclases de BocataBuilder

class BocataSerranitoBuilder extends BocataBuilder {
  @override
  void createNewBocata() {
    bocata = Bocata();
  }

  @override
  void addIngredientes() {
    bocata.ingredientes = ['aceite', 'tomate', 'jamon serrano', 'lomo', 'pimiento'];
  }

  @override
  void tipoPan() {
    bocata.pan = 'casero';
  }

  @override
  void tamanoBocata() {
    bocata.tamano = 'mediano';
  }
}

// Definición de las clases Pizza y Bocata
class Pizza {
  List<String> ingredientes = [];
  String? salsa;
  String? tipoMasa;
  String? tamano;

  @override
  String toString() {
    return 'Pizza\nIngredientes: $ingredientes\nSalsa: $salsa\nTipo de Masa: $tipoMasa\nTamaño: $tamano';
  }
}

class Bocata {
  List<String> ingredientes = [];
  String? pan;
  String? tamano;

  @override
  String toString() {
    return 'Bocata\nIngredientes: $ingredientes\nPan: $pan\nTamaño: $tamano';
  }
}

// Clase Director
class Director {
  PizzaBuilder _pizzaBuilder;
  BocataBuilder _bocataBuilder;

  Director(this._pizzaBuilder, this._bocataBuilder);

  Pizza buildPizza() {
    _pizzaBuilder.createNewPizza();
    _pizzaBuilder.addIngredientes();
    _pizzaBuilder.addSalsa();
    _pizzaBuilder.tipoMasa();
    _pizzaBuilder.tamanoPizza();
    return _pizzaBuilder.pizza;
  }

  Bocata buildBocata() {
    _bocataBuilder.createNewBocata();
    _bocataBuilder.addIngredientes();
    _bocataBuilder.tipoPan();
    _bocataBuilder.tamanoBocata();
    return _bocataBuilder.bocata;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pizza & Bocata Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pizza & Bocata Builder Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Director _director = Director(BBQPizzaBuilder(), BocataSerranitoBuilder());
  Pizza? _pizza;
  Bocata? _bocata;

  void _buildPizza() {
    setState(() {
      _pizza = _director.buildPizza();
    });
  }

  void _buildBocata() {
    setState(() {
      _bocata = _director.buildBocata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _buildPizza,
              child: Text('Construir Pizza BBQ'),
            ),
            SizedBox(height: 20),
            _pizza != null
                ? Text(
                    _pizza!.toString(),
                    textAlign: TextAlign.center,
                  )
                : Container(),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _buildBocata,
              child: Text('Construir Bocata Serranito'),
            ),
            SizedBox(height: 20),
            _bocata != null
                ? Text(
                    _bocata!.toString(),
                    textAlign: TextAlign.center,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
