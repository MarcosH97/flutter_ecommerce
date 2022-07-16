import 'dart:convert';

import 'package:e_commerce/Models/Carrito.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Utils/Config.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Componente {
  String? producto;
  int? cantidad;
  double? respaldo;

  Componente({
    this.producto,
    this.cantidad,
    this.respaldo,
  });

  void incrementCantidad() {
    cantidad = cantidad!+1;
  }
  void decrementCantidad() {
    cantidad = cantidad!+1;
  }

  void setRespaldo(double value) {
    respaldo = value;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'producto': producto,
      'cantidad': cantidad,
      'respaldo': respaldo,
    };
  }

  factory Componente.fromMap(Map<String, dynamic> map) {
    return Componente(
      producto: map['producto'] != null ? map['producto'] as String : null,
      cantidad: map['cantidad'] != null ? map['cantidad'] as int : null,
      respaldo: map['respaldo'] != null ? map['respaldo'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Componente.fromJson(String source) =>
      Componente.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ComponenteCreate {
  Componente createAndAddComponente(ProductoAct producto) {
    double respaldop = double.parse(producto.precio!.cantidad!);
    return Componente(producto: producto.id, cantidad: 1, respaldo: respaldop);
  }

  void updateRespaldo(int index) async {
    List<ProductoAct>? productos =
        await ProductoModelResponse().getProductRecList();
    productos!.forEach((element) {
      if (element.id == Config.carrito[index].producto) {
        Config.carrito[index].setRespaldo(
            double.parse(element.precio!.cantidad!) *
                    Config.carrito[index].cantidad! +
                1);
      }
    });
  }
}
