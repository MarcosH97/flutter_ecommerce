import 'package:e_commerce/Models/Login_Register/register_form_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../Models/User.dart';
import '../Utils/Config.dart';
import '../Utils/Device.dart';
import '../Widgets/glassmorph.dart';
import '../Widgets/registerBodyWidget.dart';

class registerPage extends StatefulWidget {
  registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage>
    with TickerProviderStateMixin {
  late User user;

  bool hidden = true;

  String _email = "ni",
      _password = "ni",
      _name = "ni",
      _direccion = "ni",
      _ciudad = "ni",
      _codigopos = "ni",
      _pais = "ni",
      _telefono = 'ni';

  // var textController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool isAPICallProcess = false;
  bool hidePassword = true;
  late AnimationController _controller;
  late Animation _animation;
  String? validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return "Usuario vacio";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/LoginBGDesktop.png'),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: Device().isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/logo.png'),
                      height: 180,
                      width: 600,
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: registerLast()
                          // registerBody()
                          // RegisterBody(key: _globalKey),
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //       elevation: 10,
                    //       padding: const EdgeInsets.all(20),
                    //       primary: Config.maincolor,
                    //       fixedSize: Size(
                    //           Device().isMobile(context)
                    //               ? MediaQuery.of(context).size.width / 1.5
                    //               : MediaQuery.of(context).size.width / 3,
                    //           60),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10))),
                    //   onPressed: () async {
                    //     if (_globalKey.currentState!.validate()) {
                    //       _globalKey.currentState!.save();
                    //       if (await Config().checkInternetConnection()) {
                    //         loadingDialog();
                    //         // ScaffoldMessenger.of(context).showSnackBar(
                    //         //     SnackBar(content: Text('reg_yes'.tr)));
                    //       } else {
                    //         //   // ScaffoldMessenger.of(context).showSnackBar(
                    //         //     SnackBar(content: Text('reg_no'.tr)));
                    //       }
                    //     } else {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text("No hay conexion")));
                    //     }
                    //   },
                    // },
                    //   child: Text(
                    //     'register'.tr,
                    //     textScaleFactor: 1.3,
                    //     style: TextStyle(color: Colors.white, wordSpacing: 3),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                // RegisterBody(),
                // child: registerBody(),
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(text: 'do_acc_1'.tr),
                        TextSpan(
                            text: 'do_acc_2'.tr,
                            style: TextStyle(
                                color: Colors.grey[500],
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.popAndPushNamed(context, "/login");
                              })
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          child: Wrap(
            runSpacing: 10,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                // validator: validateEmail,
                autofocus: false,
                onChanged: (String value) {
                  _email = value;
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'abc@email.com',
                    labelText: 'email'.tr),
              ),
              TextFormField(
                validator: validateFields,
                maxLines: 1,
                onChanged: (String value) {
                  _name = value;
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Armando Paredes',
                    labelText: 'name'.tr),
              ),
              TextFormField(
                autofocus: false,
                // validator: validatePW,
                maxLines: 1,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
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
                        icon: Icon(
                            hidden ? Icons.visibility_off : Icons.visibility),
                        color: Colors.grey.withOpacity(0.7)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'A1b2_34',
                    labelText: 'pw'.tr),
              ),
              TextFormField(
                onChanged: (String value) {
                  _direccion = value;
                },
                maxLines: 1,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: '5ta Ave. 245',
                    labelText: 'address'.tr),
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
                  // print(phone.number);
                },
              ),
              TextFormField(
                autofocus: false,
                maxLines: 1,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Cuba',
                    labelText: 'country'.tr),
                onChanged: (value) {
                  _pais = value;
                },
              ),
              TextFormField(
                // validator: validateFields,
                autofocus: false,
                onChanged: (String value) {
                  _ciudad = value;
                },
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'La Habana',
                  labelText: 'city'.tr,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _codigopos = value;
                },
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
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 10,
              padding: const EdgeInsets.all(20),
              primary: Config.maincolor,
              fixedSize: Size(
                  Device().isMobile(context)
                      ? MediaQuery.of(context).size.width / 1.5
                      : MediaQuery.of(context).size.width / 3,
                  60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            // if (_globalKey.currentState != null) {
            // if (_globalKey.currentState!.validate()) {
            //   print('validated');
            // }
            if (await Config().checkInternetConnection()) {
              bool b = await register_form_response().register(getUser());
              if (b) {
                showDialog(
                  context: context,
                  builder: (context) => RegisterMessage(),
                );
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('reg_yes'.tr)));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('reg_no'.tr)));
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("No hay conexion")));
            }
            // } else {
            //   print("null");
            // }
            ;
          },
          child: Text(
            'register'.tr,
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
                        'Verifique su correo',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                          'Vaya a su correo y verifique su cuenta para entrar al sitio. Diríjase a su bandeja de entrada, de no estar ahí, revise en spam, puede su correo lo haya enviado ahí.',
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
}

class registerLast extends StatefulWidget {
  registerLast({Key? key}) : super(key: key);

  @override
  State<registerLast> createState() => _registerLastState();
}

class _registerLastState extends State<registerLast> {
  final _globalKey = GlobalKey<FormState>();
  bool hidden = true;
  User u = User();

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
                        'Verifique su correo',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                          'Vaya a su correo y verifique su cuenta para entrar al sitio. Diríjase a su bandeja de entrada, de no estar ahí, revise en spam, puede su correo lo haya enviado ahí.',
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            runSpacing: 10,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                autofocus: false,
                // onChanged: (String value) {
                //   u.email = value;
                // },
                onSaved: (newValue) => u.email = newValue,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'abc@email.com',
                    labelText: 'email'.tr),
              ),
              TextFormField(
                validator: validateFields,
                maxLines: 1,
                onSaved: (newValue) => u.name = newValue,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Armando Paredes',
                    labelText: 'name'.tr),
              ),
              TextFormField(
                autofocus: false,
                validator: validatePW,
                maxLines: 1,
                onSaved: (newValue) => u.password = newValue,
                obscureText: hidden,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidden = !hidden;
                          });
                        },
                        icon: Icon(
                            hidden ? Icons.visibility_off : Icons.visibility),
                        color: Colors.grey.withOpacity(0.7)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'A1b2_34',
                    labelText: 'pw'.tr),
              ),
              TextFormField(
                maxLines: 1,
                onSaved: (newValue) => u.direccion = newValue,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: '5ta Ave. 245',
                    labelText: 'address'.tr),
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
                  u.telefono = phone.number.toString();
                  // print(phone.number);
                },
              ),
              TextFormField(
                autofocus: false,
                maxLines: 1,
                validator: validateFields,
                onSaved: (newValue) => u.pais = newValue,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Cuba',
                    labelText: 'country'.tr),
              ),
              TextFormField(
                // validator: validateFields,
                autofocus: false,
                validator: validateFields,
                onSaved: (newValue) => u.ciudad = newValue,
                maxLines: 1,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'La Habana',
                  labelText: 'city'.tr,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,
                maxLines: 1,
                validator: validateFields,
                onSaved: (newValue) => u.codigoPostal = newValue,
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
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                padding: const EdgeInsets.all(20),
                primary: Config.maincolor,
                fixedSize: Size(
                    Device().isMobile(context)
                        ? MediaQuery.of(context).size.width / 1.5
                        : MediaQuery.of(context).size.width / 3,
                    60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              // if (_globalKey.currentState != null) {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();
                // print(u.toJson());
                if (await Config().checkInternetConnection()) {
                  // print("hay conexion");
                  showDialog(
                      context: context,
                      builder: (context) => loadingDialog(),
                    );
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("No hay conexion")));
                }
              }
            },
            child: Text(
              'register'.tr,
              textScaleFactor: 1.3,
              style: TextStyle(color: Colors.white, wordSpacing: 3),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget loadingDialog() {
    return FutureBuilder(
      future: register_form_response().register(u),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              print('waiting');
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
