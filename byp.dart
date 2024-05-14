import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza & Bocata Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pizza & Bocata Builder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedUser = 'René';
  Map<String, List<Pizza>> userPizzaOrders = {
    'René': [],
    'Angela': [],
    'Gonzalo': [],
    'Migel': []
  };
  Map<String, List<Bocata>> userBocataOrders = {
    'René': [],
    'Angela': [],
    'Gonzalo': [],
    'Migel': []
  };

  void changeUser(String user) {
    setState(() {
      selectedUser = user;
    });
  }

  void addPizzaOrder(Pizza pizza) {
    setState(() {
      userPizzaOrders[selectedUser]?.add(pizza);
    });
  }

  void addBocataOrder(Bocata bocata) {
    setState(() {
      userBocataOrders[selectedUser]?.add(bocata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} - $selectedUser'),
        actions: [
          PopupMenuButton<String>(
            icon: Text(
              selectedUser,
              style: TextStyle(color: Colors.white),
            ),
            onSelected: changeUser,
            itemBuilder: (BuildContext context) {
              return ['René', 'Angela', 'Gonzalo', 'Miguel']
                  .map((String user) {
                return PopupMenuItem<String>(
                  value: user,
                  child: Text(user),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PizzaOptionsPage(
                            user: selectedUser,
                            addOrder: addPizzaOrder,
                            pizzaOrders: userPizzaOrders[selectedUser]!,
                          ),
                        ),
                      );
                    },
                    child: const Text('Pizza'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BocataOptionsPage(
                            user: selectedUser,
                            addOrder: addBocataOrder,
                            bocataOrders: userBocataOrders[selectedUser]!,
                          ),
                        ),
                      );
                    },
                    child: const Text('Bocata'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Elecciones de Pizza',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userPizzaOrders[selectedUser]!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            'Pizza ${index + 1}: ${userPizzaOrders[selectedUser]![index].nombre}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              userPizzaOrders[selectedUser]!.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Text(
                  'Elecciones de Bocata',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userBocataOrders[selectedUser]!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            'Bocata ${index + 1}: ${userBocataOrders[selectedUser]![index].nombre}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              userBocataOrders[selectedUser]!.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PizzaOptionsPage extends StatefulWidget {
  final String user;
  final Function(Pizza) addOrder;
  final List<Pizza> pizzaOrders;

  const PizzaOptionsPage(
      {super.key,
        required this.user,
        required this.addOrder,
        required this.pizzaOrders});

  @override
  State<PizzaOptionsPage> createState() => _PizzaOptionsPageState();
}

class _PizzaOptionsPageState extends State<PizzaOptionsPage> {
  late Pizza pizza;
  late PizzaBuilder builder;
  String resultado = "";

  void construirPizza() {
    setState(() {
      pizza = builder.CreateNewPizza();
      resultado = pizza.str();
      widget.addOrder(pizza);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elegir Pizza - ${widget.user}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      builder = BBQPizzaBuilder();
                      construirPizza();
                    },
                    child: const Text('Construir Pizza BBQ'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      builder = VeggiePizzaBuilder();
                      construirPizza();
                    },
                    child: const Text('Construir Pizza Veggie'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      builder = InfantilPizzaBuilder();
                      construirPizza();
                    },
                    child: const Text('Construir Pizza Infantil'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Volver'),
                  ),
                  Text(
                    'Su elección: $resultado',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.pizzaOrders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                  Text('Pizza ${index + 1}: ${widget.pizzaOrders[index].nombre}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.pizzaOrders.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BocataOptionsPage extends StatefulWidget {
  final String user;
  final Function(Bocata) addOrder;
  final List<Bocata> bocataOrders;

  const BocataOptionsPage(
      {super.key,
        required this.user,
        required this.addOrder,
        required this.bocataOrders});

  @override
  State<BocataOptionsPage> createState() => _BocataOptionsPageState();
}

class _BocataOptionsPageState extends State<BocataOptionsPage> {
  late Bocata bocata;
  late BocataBuilder builder;
  String resultado = "";

  void construirBocata() {
    setState(() {
      bocata = builder.CreateNewBocata();
      resultado = bocata.str();
      widget.addOrder(bocata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elegir Bocata - ${widget.user}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      builder = BocataSerranitoBuilder();
                      construirBocata();
                    },
                    child: const Text('Construir Bocata Serranito'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      builder = BocataCalamaresBuilder();
                      construirBocata();
                    },
                    child: const Text('Construir Bocata Calamares'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      builder = BocataPepitoBuilder();
                      construirBocata();
                    },
                    child: const Text('Construir Bocata Pepito'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Volver'),
                  ),
                  Text(
                    'Su elección: $resultado',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.bocataOrders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      'Bocata ${index + 1}: ${widget.bocataOrders[index].nombre}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.bocataOrders.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Pizza {
  var ing = <String>[];
  late String salsa;
  late String tipoMasa;
  late String tamanio;
  late String nombre;

  String str() {
    return "Ingredientes: $ing\nSalsa: $salsa\nTipo de masa: $tipoMasa\nTamaño: $tamanio";
  }
}

abstract class PizzaBuilder {
  Pizza pi = Pizza();

  Pizza CreateNewPizza() {
    AddIngredientes();
    TipoMasa();
    AddSalsa();
    TamanioMasa();
    Nombre();
    return pi;
  }

  void AddIngredientes();
  void TipoMasa();
  void AddSalsa();
  void TamanioMasa();
  void Nombre();
}

class BBQPizzaBuilder extends PizzaBuilder {
  @override
  void AddIngredientes() {
    pi.ing.add("tomate");
    pi.ing.add("queso");
    pi.ing.add("bacon");
    pi.ing.add("cebolla");
    pi.ing.add("jamon york");
  }

  @override
  void TipoMasa() {
    pi.tipoMasa = "normal con bordes rellenos de queso";
  }

  @override
  void AddSalsa() {
    pi.salsa = "Barbacoa";
  }

  @override
  void TamanioMasa() {
    pi.tamanio = "mediana";
  }

  @override
  void Nombre() {
    pi.nombre = "Barbacoa";
  }
}

class VeggiePizzaBuilder extends PizzaBuilder {
  @override
  void AddIngredientes() {
    pi.ing.add("tomate");
    pi.ing.add("queso vegano");
    pi.ing.add("champiñones");
    pi.ing.add("rúcula");
  }

  @override
  void TipoMasa() {
    pi.tipoMasa = "fina";
  }

  @override
  void AddSalsa() {
    pi.salsa = "Salsa pesto";
  }

  @override
  void TamanioMasa() {
    pi.tamanio = "mediana";
  }

  @override
  void Nombre() {
    pi.nombre = "Veggie";
  }
}

class InfantilPizzaBuilder extends PizzaBuilder {
  @override
  void AddIngredientes() {
    pi.ing.add("queso");
    pi.ing.add("jamon york");
  }

  @override
  void TipoMasa() {
    pi.tipoMasa = "normal";
  }

  @override
  void AddSalsa() {
    pi.salsa = "Salsa casera de tomate";
  }

  @override
  void TamanioMasa() {
    pi.tamanio = "pequeña";
  }

  @override
  void Nombre() {
    pi.nombre = "Infantil";
  }
}

class Bocata {
  var ing = <String>[];
  late String pan;
  late String tamanio;
  late String nombre;

  String str() {
    return "Ingredientes: $ing\nTipo de pan: $pan\nTamaño: $tamanio";
  }
}

abstract class BocataBuilder {
  Bocata bo = Bocata();

  Bocata CreateNewBocata() {
    AddIngredientes();
    TipoPan();
    Tamanio();
    Nombre();
    return bo;
  }

  void AddIngredientes();
  void TipoPan();
  void Tamanio();
  void Nombre();
}

class BocataPepitoBuilder extends BocataBuilder {
  @override
  void AddIngredientes() {
    bo.ing.add("tomate");
    bo.ing.add("lechuga");
    bo.ing.add("lomo");
    bo.ing.add("mayonesa");
  }

  @override
  void TipoPan() {
    bo.pan = "baguette";
  }

  @override
  void Tamanio() {
    bo.tamanio = "grande";
  }

  @override
  void Nombre() {
    bo.nombre = "Pepito";
  }
}

class BocataSerranitoBuilder extends BocataBuilder {
  @override
  void AddIngredientes() {
    bo.ing.add("tomate");
    bo.ing.add("aceite");
    bo.ing.add("jamon serrano");
    bo.ing.add("pimiento");
  }

  @override
  void TipoPan() {
    bo.pan = "casero";
  }

  @override
  void Tamanio() {
    bo.tamanio = "mediano";
  }

  @override
  void Nombre() {
    bo.nombre = "Serranito";
  }
}

class BocataCalamaresBuilder extends BocataBuilder {
  @override
  void AddIngredientes() {
    bo.ing.add("calamares fritos");
    bo.ing.add("mayonesa");
  }

  @override
  void TipoPan() {
    bo.pan = "artesano";
  }

  @override
  void Tamanio() {
    bo.tamanio = "mediano";
  }

  @override
  void Nombre() {
    bo.nombre = "De Calamares";
  }
}
