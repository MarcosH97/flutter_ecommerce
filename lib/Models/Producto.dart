import 'dart:ffi';

class Producto {
  late String nombre;
  late Float precio;
  late String precioLbCurrency;
  late Float precioLb;
  late String imagenUrl;
  late String descripcion;
  late Int cantInventario;

  Producto(n, p, plc, pl, url, d, ci) {
    nombre = n;
    precio = p;
    precioLbCurrency = plc;
    precioLb = pl;
    imagenUrl = url;
    descripcion = d;
    cantInventario = ci;
  }
}
