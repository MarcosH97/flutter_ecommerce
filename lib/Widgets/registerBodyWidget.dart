import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../Models/User.dart';
import '../Models/Login_Register/register_form_response.dart';
import '../Utils/Config.dart';
import '../Utils/Device.dart';
import 'glassmorph.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  var _globalKey = GlobalKey<FormFieldState>();

  late User user;
  bool hidden = true;
  // final Tcontroller = TextEditingController();
  String? validateFields(String? value) {
    if (value!.isEmpty) {
      print("campo vacio");
      return "Campo vacío";
    }
    return null;
  }

  String? validateEmail(String? v) {
    if (v! == "") {
      print("campo vacio");
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
      _pais = "ni",
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
        pais: _pais,
        telefono: _telefono);
    return user;
  }

  Widget RegisterMessage() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        alignment: Alignment.topCenter,
        // fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(top: 35),
            width: 500,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'verify'.tr,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text('verify_txt'.tr,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal)),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/login");
                        },
                        child: Text(
                          'login'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Config.maincolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize: Size(150, 30)),
                      ),
                      SizedBox(
                        height: 12,
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/logosquare.png'),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _globalKey = widget.key as GlobalKey<FormFieldState>;
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            autofocus: false,
            // onChanged: (String value) {
            //   _email = value;
            // },
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'abc@email.com',
                labelText: 'email'.tr),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: validateFields,
            autofocus: false,
            maxLines: 1,
            // onChanged: (String value) {
            //   _name = value;
            // },
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Armando Paredes',
                labelText: 'name'.tr),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            validator: validatePW,
            maxLines: 1,
            // onChanged: (String value) {
            //   setState(() {
            //     _password = value;
            //     // print('contra : ' + _password);
            //   });
            // },
            obscureText: hidden,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                    icon:
                        Icon(hidden ? Icons.visibility_off : Icons.visibility),
                    color: Colors.grey.withOpacity(0.7)),
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'A1b2_34',
                labelText: 'pw'.tr),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            // onChanged: (String value) {
            //   _direccion = value;
            // },
            maxLines: 1,
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: '5ta Ave. 245',
                labelText: 'address'.tr),
          ),
          SizedBox(
            height: 10,
          ),
          IntlPhoneField(
            // autovalidateMode: AutovalidateMode.always,
            invalidNumberMessage: "Formato de telefono incorrecto",
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: 'phone'.tr,
              border: OutlineInputBorder(),
            ),
            initialCountryCode: 'US',
            onChanged: (phone) {
              _telefono = phone.number.toString();
              print(phone.number);
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: false,
            maxLines: 1,
            decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Cuba',
                labelText: 'country'.tr),
            // onChanged: (value) {
            //   _pais = value;
            // },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  // validator: validateFields,
                  autofocus: false,
                  // onChanged: (String value) {
                  //   _ciudad = value;
                  // },
                  maxLines: 1,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'La Habana',
                    labelText: 'city'.tr,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  // onChanged: (String value) {
                  //   _codigopos = value;
                  // },
                  autofocus: false,
                  maxLines: 1,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: '10400',
                      labelStyle: TextStyle(
                        overflow: TextOverflow.visible,
                      ),
                      labelText: 'zipcode'.tr),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loadingDialog() {
    return FutureBuilder(
      future: register_form_response().register(getUser()),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          case ConnectionState.done:
            {
              if (snapshot.data == true) {
                return RegisterMessage();
              } else {
                return AlertDialog(
                  title: Text('reg_no'.tr,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Ok"))
                  ],
                );
              }
            }
          default:
            {
              break;
            }
        }
        return Text("null");
      },
    );
  }
}
