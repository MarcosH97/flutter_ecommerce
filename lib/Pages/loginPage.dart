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
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormFieldState> _globalKey = GlobalKey<FormFieldState>();
  bool isAPICallProcess = false;
  bool hidePassword = true;

  String? _username;
  String? _password;

  String? validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return "Usuario vacio";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
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
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              const Image(
                                image: AssetImage('assets/logo.png'),
                                height: 180,
                              ),
                              const FormTextHelper(
                                  label: "Usuario",
                                  hint: "amanzo",
                                  icon: Icon(Icons.person)),
                              Container(
                                height: 60,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: TextFormField(
                                  maxLines: 1,
                                  focusNode: FocusNode(),
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
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                    ),
                                    labelText: "Contrasena",
                                  ),
                                  obscureText: hidePassword,
                                ),
                              ),
                              // FormHelper.inputFieldWidget(context, 'username',
                              //     'Usuario', validateName, (onSaved) {
                              //   _username = onSaved;
                              // },
                              //     prefixIcon: const Icon(Icons.person),
                              //     showPrefixIcon: true,
                              //     prefixIconPaddingLeft: 10,
                              //     borderFocusColor: Colors.white,
                              //     borderColor: Colors.white,
                              //     textColor: Colors.grey,
                              //     hintColor: Colors.grey.withOpacity(0.7),
                              //     borderRadius: 10,
                              //     backgroundColor: Colors.white),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // FormHelper.inputFieldWidget(
                              //     context, 'password', 'Contraseña',
                              //     (onValidate) {
                              //   if (onValidate.isEmpty) {
                              //     return "El campo no puede estar vacio";
                              //   }
                              // }, (onSaved) {
                              //   _password = onSaved;
                              // },
                              //     prefixIcon: const Icon(Icons.lock),
                              //     prefixIconPaddingLeft: 10,
                              //     showPrefixIcon: true,
                              //     borderFocusColor: Colors.white,
                              //     borderColor: Colors.white,
                              //     textColor: Colors.grey,
                              //     hintColor: Colors.grey.withOpacity(0.7),
                              //     borderRadius: 10,
                              //     backgroundColor: Colors.white,
                              //     obscureText: hidePassword,
                              //     suffixIcon: IconButton(
                              //         onPressed: () {
                              //           setState(() {
                              //             hidePassword = !hidePassword;
                              //           });
                              //         },
                              //         color: Colors.grey.withOpacity(0.7),
                              //         icon: Icon(hidePassword
                              //             ? Icons.visibility_off
                              //             : Icons.visibility))),
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
                                            color: Colors.amber, fontSize: 16),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "Contraseña olvidada",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  print("forgot password");
                                                })
                                        ]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // FormHelper.submitButton("L O G I N", () {},
                  //     borderColor: Colors.transparent,
                  //     btnColor: Color.fromRGBO(22, 26, 72, 1),
                  //     txtColor: Colors.white,
                  //     width: Device().isMobile(context)
                  //         ? MediaQuery.of(context).size.width / 1.5
                  //         : MediaQuery.of(context).size.width / 3,
                  //     height: 60,
                  //     borderRadius: 10),

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
                    onPressed: () {},
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
