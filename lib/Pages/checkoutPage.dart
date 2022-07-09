import 'package:flutter/material.dart';

import '../Widgets/myAppBar.dart';

class checkOutPage extends StatefulWidget {
  checkOutPage({Key? key}) : super(key: key);

  @override
  State<checkOutPage> createState() => _checkOutPageState();
}

class _checkOutPageState extends State<checkOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context).AppBarM(),
      body: 
      Container(
        color: Colors.blue,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              height: 200,
              width: 200,
              child: ListTile(title: Text("temp"),)),
            Positioned(
              height: 300,
              width: 300,
              bottom: 0,
              child: Card(color: Colors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only()),
              ))
          ],
        ),
      ),
    );
  }
}