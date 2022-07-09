class CategoriaRequest {
  int? count;
  String? next;
  String? previous;
  List<Categoria>? results;

  CategoriaRequest({this.count, this.next, this.previous, this.results});

  CategoriaRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Categoria>[];
      json['results'].forEach((v) {
        results!.add(new Categoria.fromJson(v));
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

class Categoria {
  int? id;
  String? nombre;
  bool? especial;

  Categoria({this.id, this.nombre, this.especial});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    especial = json['especial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['especial'] = this.especial;
    return data;
  }
}
