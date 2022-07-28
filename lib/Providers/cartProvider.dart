import 'dart:math';

import 'package:e_commerce/Models/Producto.dart';
import 'package:flutter/cupertino.dart';

import '../Models/Componente.dart';

class Cart with ChangeNotifier {
  List<Componente> _lista = [];

  List<Componente> get getLista => _lista;

  int get listaSize => _lista.length;

  cleanCart() => _lista.clear();

  addProduct(Componente comp) {
    if (!inKart(comp.producto!)) {
      _lista.add(comp);
      print("added");
    } else {
      print("not added");
    }
    notifyListeners();
  }

  increaseAmmount(int index) {
    _lista[index].incrementCantidad();
    print(_lista[index].cantidad);
    notifyListeners();
  }

  decreaseAmmount(int index) {
    _lista[index].decrementCantidad();
    print(_lista[index].cantidad);
    notifyListeners();
  }

  removeProduct(int index) {
    _lista.removeAt(index);
    print("removed");
    notifyListeners();
  }

  int getCantidad(int index) {
    return _lista[index].cantidad!;
  }

  double getTotalPriceKart() {
    double total = 0;
    _lista.forEach((element) {
      // print(element.respaldo);
      total += element.respaldo!;
    });
    total = double.parse(total.toStringAsFixed(2));
    // print(total);
    return total;
  }
  // bool get Added() => inKart(id);

  bool inKart(String id) {
    bool b = false;
    _lista.forEach((element) {
      if (element.producto == id) {
        b = true;
      }
    });
    return b;
  }
}

class Wishlist with ChangeNotifier {
  List<ProductoAct> _lista = [];

  List<ProductoAct> get getLista => _lista;

  int get listaSize => _lista.length;

  cleanCart() => _lista.clear();

  addProduct(ProductoAct prod) {
    if (!inWL(prod.id!)) {
      _lista.add(prod);
      print("added");
    } else {
      print("not added");
      print(_lista);
    }
    notifyListeners();
  }

  removeProduct(int index) {
    _lista.removeAt(index);
    print("removed");
    notifyListeners();
  }

  bool inWL(String id) {
    bool b = false;
    _lista.forEach((element) {
      if (element.id == id) {
        b = true;
      }
    });
    return b;
  }

  purgeList() {
    List<ProductoAct> temp = [];
    _lista.forEach((element) {
      String id = element.id!;
      if (!inWL(id)) {
        temp.add(element);
      }
    });
    _lista = temp;
  }
}
