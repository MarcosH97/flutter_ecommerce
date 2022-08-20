import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Widgets/foodCardW.dart';
import 'package:e_commerce/Widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class filterPage extends StatefulWidget {
  final headerName;
  final String? subcat;
  final String? cat;
  final List<ProductoMun>? productos;
  filterPage({Key? key, required this.headerName, this.productos, this.subcat, this.cat})
      : super(key: key);

  @override
  State<filterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<filterPage> {

  List<ProductoMun> productos = [];
  @override
  Widget build(BuildContext context) {
    if (widget.productos != null) {
      productos = widget.productos!;
      print(productos.length);
    }
    return Scaffold(
      appBar: myAppBar(
        context: context,
        // callback: callback
      ).AppBarM(),
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
                child: productos.isNotEmpty
                    ? ListView.builder(
                        itemCount: productos.length,
                        itemBuilder: (context, index) => FoodCardW(
                              productReq: productos[index],
                              index: index,
                              // callback: callback,
                            ))
                    : FutureBuilder(
                        future: widget.cat == null ? ProductoFiltro().FilteredList(key: null, subkey: widget.subcat) : (widget.subcat == null ? ProductoFiltro()
                                .FilteredList(key: widget.cat, subkey: null): ProductoFiltro().FilteredList(
                                    key: widget.cat, subkey: widget.subcat)),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              {
                                return LinearProgressIndicator();
                              }
                            case ConnectionState.none:
                              {
                                return Text('null');
                              }
                            case ConnectionState.done:
                              {
                                if (snapshot.hasData && snapshot.data != null) {
                                  productos =
                                      snapshot.data as List<ProductoMun>;
                                  return ListView.builder(
                                      itemCount: productos.length,
                                      itemBuilder: (context, index) =>
                                          FoodCardW(
                                            productReq: productos[index],
                                            index: index,
                                            // callback: callback,
                                          ));
                                }
                                return Text('null');
                              }
                            default:
                              {
                                return Text('null');
                              }
                          }
                        }),
              ),
            ],
          )),
    );
  }
}
