class Producto2Request2 {
  int count = 0;
  List<Producto2> results = List.empty();

  Producto2Request2({required this.count,required this.results});

  Producto2Request2.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = new List.empty();
      json['results'].forEach((v) {
        results.add(new Producto2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = count;
    if (results != null) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Producto2 {
  Proveedor proveedor = Proveedor(nombre: "");
  Proveedor marca = Proveedor(nombre: "");
  Subcategoria? subcategoria;
  List<Etiquetas> etiquetas = List.empty();
  List<Municipios> municipios= List.empty();
  String nombre = "";
  String precioCurrency = "";
  String precio = "";
  String precioLbCurrency = "";
  String precioLb = "";
  String imagen = "";
  String descripcion = "";
  int cantidadInventario = 0;
  String slug = "";
  bool? visible;
  int? ventas;
  int? rebaja;

  Producto2(
      {
      required this.proveedor,
      required this.marca,
      required this.subcategoria,
      required this.etiquetas,
      required this.municipios,
      required this.nombre,
      required this.precioCurrency,
      required this.precio,
      required this.precioLbCurrency,
      required this.precioLb,
      required this.imagen,
      required this.descripcion,
      required this.cantidadInventario,
      required this.slug,
      this.visible,
      this.ventas,
      this.rebaja});

  Producto2.fromJson(Map<String, dynamic> json) {
    proveedor = (json['proveedor'] != null
        ? new Proveedor.fromJson(json['proveedor'])
        : null)!;
    marca =
        (json['marca'] != null ? new Proveedor.fromJson(json['marca']) : null)!;
    subcategoria = json['subcategoria'] != null
        ? new Subcategoria.fromJson(json['subcategoria'])
        : null;
    if (json['etiquetas'] != null) {
      etiquetas = new List.empty();
      json['etiquetas'].forEach((v) {
        etiquetas.add(new Etiquetas.fromJson(v));
      });
    }
    if (json['municipios'] != null) {
      municipios = new List.empty();
      json['municipios'].forEach((v) {
        municipios.add(new Municipios.fromJson(v));
      });
    }
    nombre = json['nombre'];
    precioCurrency = json['precio_currency'];
    precio = json['precio'];
    precioLbCurrency = json['precio_lb_currency'];
    precioLb = json['precio_lb'];
    imagen = json['imagen'];
    descripcion = json['descripcion'];
    cantidadInventario = json['cantidad_inventario'];
    slug = json['slug'];
    visible = json['visible'];
    ventas = json['ventas'];
    rebaja = json['rebaja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (proveedor != null) {
      data['proveedor'] = proveedor.toJson();
    }
    if (marca != null) {
      data['marca'] = marca.toJson();
    }
    if (subcategoria != null) {
      data['subcategoria'] = subcategoria!.toJson();
    }
    if (etiquetas != null) {
      data['etiquetas'] = etiquetas.map((v) => v.toJson()).toList();
    }
    if (municipios != null) {
      data['municipios'] = municipios.map((v) => v.toJson()).toList();
    }
    data['nombre'] = nombre;
    data['precio_currency'] = precioCurrency;
    data['precio'] = precio;
    data['precio_lb_currency'] = precioLbCurrency;
    data['precio_lb'] = precioLb;
    data['imagen'] = imagen;
    data['descripcion'] = descripcion;
    data['cantidad_inventario'] = cantidadInventario;
    data['slug'] = slug;
    data['visible'] = visible;
    data['ventas'] = ventas;
    data['rebaja'] = rebaja;
    return data;
  }
}

class Proveedor {
  String nombre = "";

  Proveedor({
    required this.nombre});

  Proveedor.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = nombre;
    return data;
  }
}

class Subcategoria {
  List<Etiquetas> etiquetas = List.empty();
  String nombre = "";
  int categoria = 0;

  Subcategoria({ 
    required this.etiquetas, 
    required this.nombre, 
    required this.categoria});

  Subcategoria.fromJson(Map<String, dynamic> json) {
    if (json['etiquetas'] != null) {
      etiquetas = new List.empty();
      json['etiquetas'].forEach((v) {
        etiquetas.add(new Etiquetas.fromJson(v));
      });
    }
    nombre = json['nombre'];
    categoria = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (etiquetas != null) {
      data['etiquetas'] = etiquetas.map((v) => v.toJson()).toList();
    }
    data['nombre'] = nombre;
    data['categoria'] = categoria;
    return data;
  }
}

class Etiquetas {
  String etiqueta = "";

  Etiquetas({
    required this.etiqueta});

  Etiquetas.fromJson(Map<String, dynamic> json) {
    etiqueta = json['etiqueta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['etiqueta'] = etiqueta;
    return data;
  }
}

class Municipios {
  int? precionEntrega;
  String nombre = "";
  int provincia = 1;

  Municipios({
    this.precionEntrega, 
    required this.nombre, 
    required this.provincia});

  Municipios.fromJson(Map<String, dynamic> json) {
    precionEntrega = json['precion_entrega'];
    nombre = json['nombre'];
    provincia = json['provincia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precion_entrega'] = precionEntrega;
    data['nombre'] = nombre;
    data['provincia'] = provincia;
    return data;
  }

  
}
