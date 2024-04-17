import 'package:flutter/material.dart';

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
        title: Text('Pizza Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Implementar acción para construir Pizza BBQ
              },
              child: Text('Construir Pizza BBQ'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar acción para construir Pizza Veggie
              },
              child: Text('Construir Pizza Veggie'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar acción para construir Pizza Infantil
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
        title: Text('Bocata Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Implementar acción para construir Bocata Serranito
              },
              child: Text('Construir Bocata Serranito'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar acción para construir Bocata Calamares
              },
              child: Text('Construir Bocata Calamares'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementar acción para construir Bocata Pepito
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
