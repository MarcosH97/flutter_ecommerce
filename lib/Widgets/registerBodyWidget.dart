import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../Models/User.dart';
import '../Models/Login_Register/register_form_response.dart';
import '../Utils/Config.dart';
import '../Utils/Device.dart';
import 'glassmorph.dart';

class RegisterBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _globalKey = GlobalKey<FormFieldState>();

  late User user;
  bool hidden = true;
  // final Tcontroller = TextEditingController();
  String? validateFields(String? value) {
    if (value!.isEmpty) {
      return "Campo vacío";
    }
    return null;
  }

  String? validateEmail(String? v) {
    if (v!.isEmpty) {
      return "Campo vacío";
    } else if (!v.contains("@")) {
      return "Formato de correo no válido";
    }
    return null;
  }

  String? validatePW(String? v) {
    if (v!.length < 8) {
      return "Contraseña corta";
    }
    return null;
  }

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
                Form(
                  key: _globalKey,
                  child: Column(
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
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          maxLines: 1,
                          onChanged: (String value) {
                            _email = value;
                          },
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              hintText: 'abc@email.com',
                              labelText: 'Correo'),
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
                        child: TextFormField(
                          validator: validateFields,
                          autofocus: false,
                          maxLines: 1,
                          onChanged: (String value) {
                            _name = value;
                          },
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              hintText: 'Armando Paredes',
                              labelText: 'Nombre'),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: TextFormField(
                          autofocus: false,
                          validator: validatePW,
                          maxLines: 1,
                          onChanged: (String value) {
                            setState(() {
                              _password = value;
                              // print('contra : ' + _password);
                            });
                          },
                          obscureText: hidden,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidden = !hidden;
                                    });
                                  },
                                  icon: Icon(hidden
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: Colors.grey.withOpacity(0.7)),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              isCollapsed: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              hintText: 'A1b2_34',
                              labelText: 'Contraseña'),
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
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              hintText: '5ta Ave. 245',
                              labelText: 'Dirección'),
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
                                    labelText: 'País'),
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
                              child: TextFormField(
                                validator: validateFields,
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
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (String value) {
                                  _codigopos = value;
                                },
                                autofocus: false,
                                maxLines: 1,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                              child: IntlPhoneField(
                                // autovalidateMode: AutovalidateMode.always,
                                invalidNumberMessage:
                                    "Formato de telefono incorrecto",
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: 'Teléfono',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                initialCountryCode: 'US',
                                onChanged: (phone) {
                                  _telefono = phone.toString();
                                  print(phone);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
            // print(getUser().email);

            if (await Config().checkInternetConnection()) {
              bool b = await register_form_response().register(getUser());
              if (b) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Registro Exitoso")));
                Navigator.popAndPushNamed(context, "/login");
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Registro Fallido")));
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("No hay conexion")));
            }
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
