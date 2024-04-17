import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza & Bocata Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pizza & Bocata Builder'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              //Cuando se pulse iriamos a la pagina pizzaoptionspage
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PizzaOptionsPage()),
                );
              },
              child: Text('Pizza'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BocataOptionsPage()),
                );
              },
              child: Text('Bocata'),
            ),
          ],
        ),
      ),
    );
  }
}

class PizzaOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elegir Pizza'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Añadir codigo de que hace cada boton
              },
              child: Text('Construir Pizza BBQ'),
            ),
            ElevatedButton(
              onPressed: () {
                 // Añadir codigo de que hace cada boton
              },
              child: Text('Construir Pizza Veggie'),
            ),
            ElevatedButton(
              onPressed: () {
                 // Añadir codigo de que hace cada boton
              },
              child: Text('Construir Pizza Infantil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

class BocataOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elegir Bpocata'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                 // Añadir codigo de que hace cada boton
              },
              child: Text('Construir Bocata Serranito'),
            ),
            ElevatedButton(
              onPressed: () {
                 // Añadir codigo de que hace cada boton
              },
              child: Text('Construir Bocata Calamares'),
            ),
            ElevatedButton(
              onPressed: () {
                // Añadir codigo de que hace cada boton
              },
              child: Text('Construir Bocata Pepito'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
