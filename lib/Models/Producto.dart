import 'dart:ffi';

class Producto {
  late String nombre;
  late String marca;
  late Float precio;
  late Float descuento;

  Producto(n, m, p, d) {
    nombre = n;
    marca = m;
    precio = p;
    descuento = d;
  }

}
