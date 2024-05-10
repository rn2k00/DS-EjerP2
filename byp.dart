void AddIngredientes();

  void TipoMasa();

  void AddSalsa();

  void TamanioMasa();

  void Nombre();
}

class BBQPizzaBuilder extends PizzaBuilder{
  @override
  void AddIngredientes(){
    pi.ing.add("tomate");
    pi.ing.add("queso");
    pi.ing.add("bacon");
    pi.ing.add("cebolla");
    pi.ing.add("jamon york");
  }

  @override
  void TipoMasa(){
    pi.tipoMasa = "normal con bordes rellenos de queso";
  }

  @override
  void AddSalsa(){
    pi.salsa = "Barbacoa";

  }

  @override
  void TamanioMasa(){
    pi.tamanio = "mediana";

  }

  @override
  void Nombre(){
    pi.nombre = "Barbacoa";
  }
}

class VeggiePizzaBuilder extends PizzaBuilder{
  @override
  void AddIngredientes(){
    pi.ing.add("tomate");
    pi.ing.add("queso vegano");
    pi.ing.add("champiñones");
    pi.ing.add("rúcula");
  }

  @override
  void TipoMasa(){
    pi.tipoMasa = "fina";
  }

  @override
  void AddSalsa(){
    pi.salsa = "Salsa pesto";

  }

  @override
  void TamanioMasa(){
    pi.tamanio = "mediana";

  }

  @override
  void Nombre(){
    pi.nombre = "Veggie";
  }
}

class InfantilPizzaBuilder extends PizzaBuilder{
  @override
  void AddIngredientes(){
    pi.ing.add("queso");
    pi.ing.add("jamon york");
  }

  @override
  void TipoMasa(){
    pi.tipoMasa = "normal";
  }

  @override
  void AddSalsa(){
    pi.salsa = "Salsa casera de tomate";

  }

  @override
  void TamanioMasa(){
    pi.tamanio = "pequeña";

  }

  @override
  void Nombre(){
    pi.nombre = "Infantil";
  }
}




class Bocata{
  var ing = <String>[];
  late String pan;
  late String tamanio;
  late String nombre;

  String str(){
    return "Ingredientes: $ing\nTipo de pan :$pan\nTamaño :$tamanio";
  }
}

abstract class BocataBuilder{
  Bocata bo = Bocata();
  Bocata CreateNewBocata(){
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

class BocataPepitoBuilder extends BocataBuilder{

  @override
  void AddIngredientes(){
    bo.ing.add("tomate");
    bo.ing.add("lechuga");
    bo.ing.add("lomo");
    bo.ing.add("mayonesa");
  }

  @override
  void TipoPan(){

    bo.pan = "bagguette";

  }

  @override
  void Tamanio(){

    bo.tamanio = "grande";

  }

  @override
  void Nombre(){
    bo.nombre = "Pepito";
  }

}

class BocataSerranitoBuilder extends BocataBuilder{

  @override
  void AddIngredientes(){
    bo.ing.add("tomate");
    bo.ing.add("aceite");
    bo.ing.add("jamon serrano");
    bo.ing.add("pimiento");
  }

  @override
  void TipoPan(){

    bo.pan = "casero";

  }

  @override
  void Tamanio(){

    bo.tamanio = "mediano";

  }

  @override
  void Nombre(){
    bo.nombre = "Serranito";
  }

}

class BocataCalamaresBuilder extends BocataBuilder{

  @override
  void AddIngredientes(){
    bo.ing.add("calamares fritos");
    bo.ing.add("mayonesa");
  }

  @override
  void TipoPan(){

    bo.pan = "artesano";

  }

  @override
  void Tamanio(){

    bo.tamanio = "mediano";

  }

  @override
  void Nombre(){
    bo.nombre = "De Calamares";
  }

}
