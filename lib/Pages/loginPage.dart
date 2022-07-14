import 'package:e_commerce/Models/Login_Register/loginModelResponse.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Widgets/formPasswordHelper.dart';
import 'package:e_commerce/Widgets/formTextHelper.dart';
import 'package:e_commerce/Widgets/glassmorph.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utils/Device.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _loginPageState();
}
class _loginPageState extends State<loginPage> {
  final textController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool hidePassword = true;

  String? _username;
  String? _password;

  String? validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return "Usuario vacio";
    } else if (!(value!.contains("@"))) {
      return "Correo no válido";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return "Contraseña demasiado corta";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: RawKeyboardListener(
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
            Navigator.popAndPushNamed(context, '/home');
          }
        },
        focusNode: FocusNode(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/LoginBGDesktop.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Container(
                    width: Device().isMobile(context)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 3,
                    child: Card(
                      margin: Device().isMobile(context)
                          ? EdgeInsets.only(top: 80, left: 20, right: 20)
                          : EdgeInsets.only(top: 80),
                      color: Colors.transparent,
                      child: Glassmorphism(
                          blur: 30,
                          opacity: 0.3,
                          borderRadius: BorderRadius.circular(20),
                          child: Form(
                            key: _globalKey,
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                const Image(
                                  image: AssetImage('assets/logo.png'),
                                  height: 180,
                                ),
                                Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      validator: validateName,
                                      onSaved: (String? value) {
                                        this._username = value;
                                        // print(value);
                                      },
                                      // controller: textController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          isCollapsed: true,
                                          prefixIcon: Icon(Icons.person),
                                          labelText: "Usuario",
                                          hintText: "abc@gmail.com",
                                          focusColor: Colors.blue)),
                                ),
                                Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: TextFormField(
                                    validator: validatePassword,
                                    onSaved: (value) {
                                      this._password = value;
                                      // print(value);
                                    },
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      prefixIcon: Icon(Icons.lock),
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: hidePassword
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        color: Colors.grey.withOpacity(0.7),
                                        onPressed: () {
                                          hidePassword = !hidePassword;
                                        },
                                      ),
                                      labelText: "Contraseña",
                                    ),
                                    obscureText: hidePassword,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 16),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Contraseña olvidada",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    decoration: TextDecoration
                                                        .underline),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        print(
                                                            "forgot password");
                                                      })
                                          ]),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[900]),
                        fixedSize: MaterialStateProperty.all(Size(
                            Device().isMobile(context)
                                ? MediaQuery.of(context).size.width / 1.5
                                : MediaQuery.of(context).size.width / 3,
                            60)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      // print("Entered login");
                      if (_globalKey.currentState!.validate()) {
                        _globalKey.currentState!.save();
                        // _username = textController.text.toString();

                        bool s = await LoginModelResponse.login(
                            _username.toString(), _password.toString());
                        if (s) {
                          Navigator.of(context).popAndPushNamed("/home");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login Exitoso")));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Credenciales Incorrectas"),
                                );
                              });
                        }
                      }
                    },
                    child: const Text(
                      'L O G I N',
                      textScaleFactor: 1.3,
                      style: TextStyle(color: Colors.white, wordSpacing: 3),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.amber, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "¿No tiene cuenta?"),
                            TextSpan(
                                text: "¡Cree una!",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, "/register");
                                  })
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
