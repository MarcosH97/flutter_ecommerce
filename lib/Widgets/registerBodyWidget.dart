import 'package:flutter/material.dart';

import '../Models/User.dart';
import '../Models/register_form_response.dart';
import '../Utils/Device.dart';
import 'glassmorph.dart';

class RegisterBody extends StatefulWidget {
  

  @override
  State<StatefulWidget> createState() => _RegisterBodyState();
}
class _RegisterBodyState extends State<RegisterBody>{

  late User user;

  // final Tcontroller = TextEditingController();

  String _email = "ni",
      _password = "ni",
      _name = "ni",
      _direccion = "ni",
      _ciudad = "ni",
      _codigopos = "ni",
      _telefono = 'ni';

  User getUser() {
    print('entered get user. Name: $_name');
    user = User(
        email: _email,
        password: _password,
        name: _name,
        direccion: _direccion,
        ciudad: _ciudad,
        codigoPostal: _codigopos,
        telefono: _telefono);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Glassmorphism(
            blur: 30,
            opacity: 0.3,
            borderRadius: BorderRadius.circular(20),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/logo.png'),
                  height: 180,
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Expanded(
                        child:
                            // TextFieldHelper()
                            //     .InputField("Correo", 'abc@gmail.com', null, Tcontroller, () {
                            //   print('test');
                            // }),
                            TextField(
                          autofocus: false,
                          maxLines: 1,
                          onChanged: (String value) {
                            _email = value;
                          },
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Expanded(
                        child: TextField(
                          autofocus: false,
                          maxLines: 1,
                          onChanged: (String value) {
                            _name = value;
                          },
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Expanded(
                        child: TextField(
                          autofocus: false,
                          maxLines: 1,
                          onChanged: (String value) {
                            setState(() {
                              _password = value;
                            // print('contra : ' + _password);
                            });
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'A1b2_34',
                              labelText: 'Contrasenna'),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Expanded(
                        child: TextField(
                          autofocus: false,
                          onChanged: (String value) {
                            _direccion = value;
                          },
                          maxLines: 1,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: const Expanded(
                              child: TextField(
                                autofocus: false,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Expanded(
                              child: TextField(
                                autofocus: false,
                                onChanged: (String value) {
                                  _ciudad = value;
                                },
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Expanded(
                              child: TextField(
                                onChanged: (String value) {
                                  _codigopos = value;
                                },
                                autofocus: false,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Expanded(
                              child: TextField(
                                autofocus: false,
                                onChanged: (String value) {
                                  _telefono = value;
                                },
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: '52641111',
                                    labelText: 'Telefono'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
              fixedSize: MaterialStateProperty.all(Size(
                  Device().isMobile(context)
                      ? MediaQuery.of(context).size.width / 1.5
                      : MediaQuery.of(context).size.width / 3,
                  60)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          onPressed: () async {
            print(getUser().email);
            bool b = await register_form_response().register(getUser());
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(b ? "User Registered" : "Error"),
                  );
                });
          },
          child: const Text(
            'R E G I S T R A R',
            textScaleFactor: 1.3,
            style: TextStyle(color: Colors.white, wordSpacing: 3),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
