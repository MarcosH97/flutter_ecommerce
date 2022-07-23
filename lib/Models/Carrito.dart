import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:e_commerce/Models/Componente.dart';
import 'package:e_commerce/Utils/Config.dart';

class Carrito {
  int? pk;
  int? id;
  int? user;
  List<Componente>? componentes;

  Carrito({this.pk, this.id, this.user});

  Carrito.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    user = json['user'];
    if (json['componentes'] != null) {
      componentes = <Componente>[];
      json['componentes'].forEach((v) {
        componentes!.add(new Componente.fromJson(v));
      });
    }
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['user'] = this.user;
    if (this.componentes != null) {
      data['componentes'] = this.componentes!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<bool> createCarrito(int user_id) async {
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/carrito/');

    var body = {"user": "$user_id"};
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print(resBody);
      return true;
    } else {
      // print("ERROR Carrito: ${res.reasonPhrase}");
      return false;
    }
  }
}

class Componente_Carrito {
  int? id;
  int? cantidad;
  int? carrito;
  int? producto;

  Componente_Carrito({this.id, this.cantidad, this.carrito, this.producto});

  Componente_Carrito.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cantidad = json['cantidad'];
    carrito = json['carrito'];
    producto = json['producto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cantidad'] = this.cantidad;
    data['carrito'] = this.carrito;
    data['producto'] = this.producto;
    return data;
  }

  Future<bool> createCompCart(Componente_Carrito cc) async {
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token,
      'Content-Type': 'application/json'
    };
    var url =
        Uri.parse('https://www.diplomarket.com/backend/componente_carrito/');

    var body = {"carrito": cc.carrito, "producto": cc.producto};
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      return true;
    } else {
      print(res.reasonPhrase);
      return false;
    }
  }
}

class CarritoModelResponse {
  Future<Carrito> getCarrito(int id) async {
    var headersList = {
      'Accept-Language': Config.language,
      'Authorization': Config.token
    };
    var url = Uri.parse('https://www.diplomarket.com/backend/carrito/');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    Carrito carrito = Carrito();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      List<dynamic> body = jsonDecode(resBody)['results'];
      body.forEach(
        (element) {
          var c = Carrito.fromJson(element);
          if (c.user == id) {
            carrito = c;
          }
        },
      );
      if (carrito.user == null) {
        if (await Carrito().createCarrito(id)) {
          print("carrito en obtencion");
          return getCarrito(id);
        }
      } else {
        return carrito;
      }
    } else {
      print("ERROR CarritoResp: ${res.reasonPhrase}");
    }
    return Carrito();
  }
}

class CarritoPayPal {
  List<ComponentePaypal>? items;

  CarritoPayPal({
    this.items,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(items != null){
      result.addAll({'items': items!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory CarritoPayPal.fromMap(Map<String, dynamic> map) {
    return CarritoPayPal(
      items: map['items'] != null ? List<ComponentePaypal>.from(map['items']?.map((x) => ComponentePaypal.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarritoPayPal.fromJson(String source) => CarritoPayPal.fromMap(json.decode(source));
}

class ComponentePaypal {
  String? name;
  String? quantity;
  String? price;
  String? currency;

  ComponentePaypal({
    this.name,
    this.quantity,
    this.price,
    this.currency,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }
    if (price != null) {
      result.addAll({'price': price});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }

    return result;
  }

  factory ComponentePaypal.fromMap(Map<String, dynamic> map) {
    return ComponentePaypal(
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ComponentePaypal.fromJson(String source) =>
      ComponentePaypal.fromMap(json.decode(source));
}

class Items {
  List<ComponentePaypal>? items;

  Items({this.items});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ComponentePaypal>[];
      json['items'].forEach((v) {
        items!.add(new ComponentePaypal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(items != null){
      result.addAll({'items': items!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      items: map['items'] != null ? List<ComponentePaypal>.from(map['items']?.map((x) => ComponentePaypal.fromMap(x))) : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Items.fromJson(String source) => Items.fromMap(json.decode(source));
}

class Itemz {
  String? name;
  String? quantity;
  String? price;
  String? currency;

  Itemz({this.name, this.quantity, this.price, this.currency});

  Itemz.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}

