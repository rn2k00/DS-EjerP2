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

// Implementación de las subclases de PizzaBuilder
class PizzaInfantilBuilder extends PizzaBuilder {
  @override
  void createNewPizza() {
    pizza = Pizza();
  }

  @override
  void addIngredientes() {
    pizza.ingredientes = ['salsa de tomate', 'queso', 'salchichas', 'jamón', 'aceitunas', 'piña'];
  }

  @override
  void addSalsa() {
    pizza.salsa = 'tomate';
  }

  @override
  void tipoMasa() {
    pizza.tipoMasa = 'tradicional';
  }

  @override
  void tamanoPizza() {
    pizza.tamano = 'pequeño';
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
// Implementación de las subclases de PizzaBuilder
class VeggiePizzaBuilder extends PizzaBuilder {
  @override
  void createNewPizza() {
    pizza = Pizza();
  }

  @override
  void addIngredientes() {
    pizza.ingredientes = ['salsa de tomate', 'queso', 'berenjena', 'pimiento', 'cebolla', 'tomate'];
  }

  @override
  void addSalsa() {
    pizza.salsa = 'tomate';
  }

  @override
  void tipoMasa() {
    pizza.tipoMasa = 'integral';
  }

  @override
  void tamanoPizza() {
    pizza.tamano = 'grande';
  }
}

// Implementación de las subclases de BocataBuilder
class BocataCalamaresBuilder extends BocataBuilder {
  @override
  void createNewBocata() {
    bocata = Bocata();
  }

  @override
  void addIngredientes() {
    bocata.ingredientes = ['pan de baguette', 'calamares fritos', 'lechuga', 'tomate', 'mayonesa'];
  }

  @override
  void tipoPan() {
    bocata.pan = 'baguette';
  }

  @override
  void tamanoBocata() {
    bocata.tamano = 'grande';
  }
}

// Implementación de las subclases de BocataBuilder
class BocataPepitoBuilder extends BocataBuilder {
  @override
  void createNewBocata() {
    bocata = Bocata();
  }

  @override
  void addIngredientes() {
    bocata.ingredientes = ['pan de mollete', 'filete de ternera', 'pimiento', 'cebolla', 'queso'];
  }

  @override
  void tipoPan() {
    bocata.pan = 'mollete';
  }

  @override
  void tamanoBocata() {
    bocata.tamano = 'mediano';
  }
}

// Clase Director
class Director {
  PizzaBuilder? _pizzaBuilder;
  BocataBuilder? _bocataBuilder;

  Director();

  set pizzaBuilder(PizzaBuilder builder) {
    _pizzaBuilder = builder;
  }

  set bocataBuilder(BocataBuilder builder) {
    _bocataBuilder = builder;
  }

  Pizza? buildPizza() {
    if (_pizzaBuilder != null) {
      _pizzaBuilder!.createNewPizza();
      _pizzaBuilder!.addIngredientes();
      _pizzaBuilder!.addSalsa();
      _pizzaBuilder!.tipoMasa();
      _pizzaBuilder!.tamanoPizza();
      return _pizzaBuilder!.pizza;
    }
    return null;
  }

  Bocata? buildBocata() {
    if (_bocataBuilder != null) {
      _bocataBuilder!.createNewBocata();
      _bocataBuilder!.addIngredientes();
      _bocataBuilder!.tipoPan();
      _bocataBuilder!.tamanoBocata();
      return _bocataBuilder!.bocata;
    }
    return null;
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
  Director _director = Director();
  Pizza? _pizza;
  Bocata? _bocata;

  void _buildPizza(PizzaBuilder builder) {
    setState(() {
      _director.pizzaBuilder = builder;
      _pizza = _director.buildPizza();
    });
  }

  void _buildBocata(BocataBuilder builder) {
    setState(() {
      _director.bocataBuilder = builder;
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
              onPressed: () => _buildPizza(BBQPizzaBuilder()),
              child: Text('Construir Pizza BBQ'),
            ),
            ElevatedButton(
              onPressed: () => _buildPizza(VeggiePizzaBuilder()),
              child: Text('Construir Pizza Veggie'),
            ),
            ElevatedButton(
              onPressed: () => _buildPizza(PizzaInfantilBuilder()),
              child: Text('Construir Pizza Infantil'),
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
              onPressed: () => _buildBocata(BocataSerranitoBuilder()),
              child: Text('Construir Bocata Serranito'),
            ),
            ElevatedButton(
              onPressed: () => _buildBocata(BocataCalamaresBuilder()),
              child: Text('Construir Bocata Calamares'),
            ),
            ElevatedButton(
              onPressed: () => _buildBocata(BocataPepitoBuilder()),
              child: Text('Construir Bocata Pepito'),
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
