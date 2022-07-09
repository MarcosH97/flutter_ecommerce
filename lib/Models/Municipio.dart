class Municipios {
  int? count;
  String? next;
  String? previous;
  List<Municipio>? results;

  Municipios({this.count, this.next, this.previous, this.results});

  Municipios.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Municipio>[];
      json['results'].forEach((v) {
        results!.add(new Municipio.fromJson(v));
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

class Municipio {
  int? id;
  double? precionEntrega;
  String? nombre;
  int? provincia;

  Municipio({this.id, this.precionEntrega, this.nombre, this.provincia});

  Municipio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    precionEntrega = json['precion_entrega'];
    nombre = json['nombre'];
    provincia = json['provincia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['precion_entrega'] = this.precionEntrega;
    data['nombre'] = this.nombre;
    data['provincia'] = this.provincia;
    return data;
  }
}
