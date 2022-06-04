import 'package:e_commerce/Widgets/glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../Utils/Device.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormFieldState<String>> _password =
      GlobalKey<FormFieldState<String>>();

  String? _username;

  String? validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return "Usuario vacio";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Login01bg.png'),
                  fit: BoxFit.cover)),
          width: Device().isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Card(
                margin: Device().isMobile(context)
                    ? EdgeInsets.only(top: 80, left: 20, right: 20)
                    : EdgeInsets.only(top: 80),
                color: Colors.transparent,
                child: Glassmorphism(
                    blur: 20,
                    opacity: 0.7,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Image(
                          image: AssetImage('assets/logo.png'),
                          height: 200,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        FormHelper.inputFieldWidget(
                            context, 'username', 'Usuario', validateName,
                            (onSaved) {
                          _username = onSaved;
                        },
                            borderFocusColor: Colors.white,
                            borderColor: Colors.white,
                            textColor: Colors.grey,
                            hintColor: Colors.grey.withOpacity(0.7),
                            borderRadius: 10,
                            backgroundColor: Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                        FormHelper.inputFieldWidget(
                            context, 'password', 'Contraseña', validateName,
                            (onSaved) {
                          _username = onSaved;
                        },
                            borderFocusColor: Colors.white,
                            borderColor: Colors.white,
                            textColor: Colors.grey,
                            hintColor: Colors.grey.withOpacity(0.7),
                            borderRadius: 10,
                            backgroundColor: Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
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
                    fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 1.5, 60)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {},
                child: const Text(
                  'L O G I N',
                  textScaleFactor: 1.3,
                  style: TextStyle(color: Colors.white, wordSpacing: 3),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '¿Aún no tienes cuenta? ¡Crea una ya!',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.none,
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                ),
              ),
              const Card(
                color: Colors.transparent,
                child: Text(
                  '¿Aún no tienes cuenta? ¡Crea una ya!',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
