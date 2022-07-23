import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Widgets/foodCardW.dart';
import 'package:e_commerce/Widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class filterPage extends StatefulWidget {
  final headerName;
  final List<ProductoAct> productos;
  filterPage({Key? key, required this.headerName, required this.productos})
      : super(key: key);

  @override
  State<filterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<filterPage> {
  List<ProductoAct> productos = [];
  @override
  Widget build(BuildContext context) {
    productos = widget.productos;
    return Scaffold(
      appBar: myAppBar(context: context).AppBarM(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.headerName}",
                style: TextStyle(fontSize: 24),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) =>
                        FoodCardW(productReq: productos[index], index: index)),
              ),
            ],
          )),
    );
  }
}