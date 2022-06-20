import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/Device.dart';
import '../Widgets/glassmorph.dart';
import '../Widgets/registerBodyWidget.dart';

class registerPage extends StatefulWidget {
  registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
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
    return 
    Form(
      key: _globalKey,
      child: RawKeyboardListener(
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
            Navigator.popAndPushNamed(context, '/home');
          }
        },
        focusNode: FocusNode(),
        child: 
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/LoginBGDesktop.png'),
                      fit: BoxFit.cover)),
              child: 
              SingleChildScrollView(
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
                                RegisterBody(),
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
                        'R E G I S T R A R',
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
                              TextSpan(text: "¿Ya tiene cuenta?"),
                              TextSpan(
                                  text: "Entre aqui",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.popAndPushNamed(
                                          context, "/login");
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
          ],
        ),
      ),
    );
  }
}


