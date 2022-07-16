import 'Producto.dart';

class CarritoRequest {
  int? count;
  Null? next;
  Null? previous;
  List<Carrito>? results;

  CarritoRequest({this.count, this.next, this.previous, this.results});

  CarritoRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Carrito>[];
      json['results'].forEach((v) {
        results!.add(new Carrito.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carrito {
  int? user;
  List<String>? componentes;

  Carrito({this.user, this.componentes});

  Carrito.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    if (json['componentes'] != null) {
      componentes = <String>[];
      json['componentes'].forEach((v) {
        componentes!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    if (this.componentes != null) {
      data['componentes'] = this.componentes!.map((v) => v).toList();
    }
    return data;
  }
}

class Comp_Carrito {
  int? cantidad;
  int? carrito;
  int? producto;
}
