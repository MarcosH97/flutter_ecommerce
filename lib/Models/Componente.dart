import 'dart:convert';

import 'package:e_commerce/Models/Carrito.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Models/ProductoModelResponse.dart';
import 'package:e_commerce/Utils/Config.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Componente {
  int? producto;
  int? cantidad;
  double? respaldo;

  Componente({
    this.producto,
    this.cantidad,
    this.respaldo,
  });

  void incrementCantidad() {
    cantidad = cantidad! + 1;
    print('cantidad+: $cantidad');
  }

  void decrementCantidad() {
    cantidad = cantidad! - 1;
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
      producto: map['producto'] != null ? map['producto'] as int : null,
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
    return Componente(producto: int.parse(producto.id!), cantidad: 1, respaldo: respaldop);
  }

  void updateRespaldo(int index) {
    // List<ProductoAct>? productos =
    //     await ProductoModelResponse().getProductRecList();
    // productos!.forEach((element) {
    //   if (element.id == Config.carrito[index].producto) {
    //     Config.carrito[index].setRespaldo(
    //         double.parse(element.precio!.cantidad!) *
    //                 Config.carrito[index].cantidad! +
    //             1);
    //   }
    // });
    Componente c = Config.carrito[index];

    double value = c.cantidad! *
        Config().getProductFinalPrice(Config().getProductoLocal(c));
    Config.carrito[index].setRespaldo(value);
  }
}

class ComponenteSec {
  ProductoAct? producto;
  String? cantidad;
  ComponenteSec({
    this.producto,
    this.cantidad,
  });

  
ComponenteSec.fromJson(Map<String, dynamic> json) {
		producto = json['producto'] != null ? new ProductoAct.fromJson(json['producto']) : null;
		cantidad = json['cantidad'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.producto != null) {
      data['producto'] = this.producto!.toJson();
    }
		data['cantidad'] = this.cantidad;
		return data;
	}
}
