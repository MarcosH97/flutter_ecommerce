import 'package:flutter/material.dart';

class RegisterBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: const Expanded(
            child: TextField(
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'abc@email.com',
                  labelText: 'Correo'),
            ),
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: const Expanded(
            child: TextField(
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Armando Paredes',
                  labelText: 'Nombre'),
            ),
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: const Expanded(
            child: TextField(
              autofocus: false,
              maxLines: 1,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: '1234',
                  labelText: 'Contrasenna'),
            ),
          ),
        ),
        Container(
          height: 50,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: const Expanded(
            child: TextField(
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: '5ta Ave. 245',
                  labelText: 'Direccion'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Expanded(
                  child: TextField(
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: '1',
                        labelText: 'Pais'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Expanded(
                  child: TextField(
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'La Habana',
                      labelText: 'Ciudad',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Expanded(
                  child: TextField(
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: '10400',
                        labelStyle: TextStyle(
                          overflow: TextOverflow.visible,
                        ),
                        labelText: 'C. Postal'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Expanded(
                  child: TextField(
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: '52641111',
                        labelText: 'Telefono'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
