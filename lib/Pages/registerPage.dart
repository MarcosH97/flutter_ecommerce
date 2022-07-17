import 'package:e_commerce/Models/Login_Register/register_form_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Models/User.dart';
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

  // var textController = TextEditingController();

  bool isAPICallProcess = false;
  bool hidePassword = true;

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: Device().isMobile(context)
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width / 3,
                      child: RegisterBody(),
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
