// ignore_for_file: unnecessary_import

import 'package:e_commerce/Models/Login_Register/loginModelResponse.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Widgets/formPasswordHelper.dart';
import 'package:e_commerce/Widgets/formTextHelper.dart';
import 'package:e_commerce/Widgets/glassmorph.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import '../Utils/Device.dart';
import 'package:get/get.dart';

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

  bool loading = false;

  String? validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return 'val_user_empty'.tr;
    } else if (!(value!.contains("@"))) {
      return 'val_user_email'.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return 'val_pw_short'.tr;
    } else if (value == "") {
      return 'val_pw_empty'.tr;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
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
                child: Card(
                  color: Colors.transparent,
                  elevation: 15,
                  margin: Device().isMobile(context)
                      ? EdgeInsets.only(top: 80, left: 20, right: 20)
                      : EdgeInsets.only(top: 80),
                  child: Glassmorphism(
                    blur: 50,
                    borderRadius: BorderRadius.circular(10),
                    opacity: 0.2,
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          const Image(
                            image: AssetImage('assets/logoshield.png'),
                            height: 180,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                                cursorColor: Config.maincolor,
                                keyboardType: TextInputType.emailAddress,
                                textAlignVertical: TextAlignVertical.center,
                                validator: validateName,
                                onSaved: (String? value) {
                                  this._username = value;
                                },
                                // controller: textController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.all(10),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Config.maincolor,
                                    )),
                                    border: OutlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    isCollapsed: true,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Config.maincolor,
                                    ),
                                    labelText: 'email'.tr,
                                    hintText: "abc@gmail.com",
                                    focusColor: Config.maincolor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              validator: validatePassword,
                              onSaved: (value) {
                                this._password = value;
                                // print(value);
                              },
                              maxLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Config.maincolor,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Config.maincolor)),
                                focusColor: Config.maincolor,
                                isCollapsed: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Config.maincolor,
                                ),
                                border: OutlineInputBorder(),
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
                                labelText: 'pw'.tr,
                              ),
                              obscureText: hidePassword,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (loading)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: LinearProgressIndicator(
                                backgroundColor: Color.fromARGB(75, 0, 0, 0),
                              ),
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
                                          text: "pw_fgn".tr,
                                          style: TextStyle(
                                              color: Colors.grey,
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
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    primary: Colors.indigo[900],
                    fixedSize: Size(
                        Device().isMobile(context)
                            ? MediaQuery.of(context).size.width / 1.5
                            : MediaQuery.of(context).size.width / 3,
                        60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  if (_globalKey.currentState!.validate()) {
                    _globalKey.currentState!.save();
                    // var prog = ProgressDialog(
                    //     context: context, barrierDismissible: false);
                    // prog.showMaterial(
                    //     layout: MaterialProgressDialogLayout
                    //         .overlayCircularProgressIndicator);
                    setState(() {
                      loading = true;
                    });
                    if (await LoginModelResponse.login(
                        _username.toString(), _password.toString())) {
                      setState(() {
                        loading = false;
                      });
                      Navigator.of(context).pushReplacementNamed('/home');
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('login_no'.tr,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                      child: Text("Ok"))
                                ],
                              ));
                    }
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => loadingDialog(context),
                    // );
                  }
                },
                child: Text(
                  'login'.tr,
                  textScaleFactor: 1.3,
                  style: TextStyle(color: Colors.white, wordSpacing: 3),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(text: "no_acc_1".tr),
                        TextSpan(
                            text: "no_acc_2".tr,
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
              Wrap(
                children: [
                  ActionChip(
                    backgroundColor: Config.lang ? Colors.white : Colors.grey,
                    label: Text('Esp',
                        style: TextStyle(
                            color: Config.lang
                                ? Config.maincolor
                                : Colors.black)),
                    onPressed: () {
                      setState(() {
                        Config.lang = true;
                        Config.language = 'es-es';
                        Get.updateLocale(Locale('es', 'ES'));
                      });
                    },
                    avatar: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Simplified_Flag_of_Spain_%28civil_variant%29.svg/1024px-Simplified_Flag_of_Spain_%28civil_variant%29.svg.png')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    label: Text(
                      'Eng',
                      style: TextStyle(
                          color:
                              Config.lang ? Colors.black : Config.maincolor),
                    ),
                    backgroundColor: Config.lang ? Colors.grey : Colors.white,
                    onPressed: () {
                      setState(() {
                        Config.lang = false;
                        Config.language = 'en-en';
                        Get.updateLocale(Locale('en', 'US'));
                      });
                    },
                    avatar: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://purepng.com/public/uploads/large/purepng.com-american-flagflagscountrylandflag-831523995311m0uxm.png')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingDialog(BuildContext outcontext) {
    return FutureBuilder(
      future:
          LoginModelResponse.login(_username.toString(), _password.toString()),
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
                Navigator.pop(context);
                Navigator.of(outcontext).popAndPushNamed("/home");
                break;
              } else {
                return AlertDialog(
                  title: Text('login_no'.tr,
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
