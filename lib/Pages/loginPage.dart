// ignore_for_file: unnecessary_import

import 'package:e_commerce/Models/Login_Register/loginModelResponse.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Widgets/formPasswordHelper.dart';
import 'package:e_commerce/Widgets/formTextHelper.dart';
import 'package:e_commerce/Widgets/glassmorph.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 1,
                                  validator: validateName,
                                  onSaved: (String? value) {
                                    this._username = value;
                                    // print(value);
                                  },
                                  // controller: textController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      isCollapsed: true,
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'user'.tr,
                                      hintText: "abc@gmail.com",
                                      focusColor: Colors.blue)),
                            ),
                            Container(
                              height: 60,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
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

                    // bool s = await LoginModelResponse.login(
                    //     _username.toString(), _password.toString());
                    // if (s) {
                    //   Navigator.of(context).popAndPushNamed("/home");
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text("login_yes".tr)));
                    // } else {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return AlertDialog(
                    //           content: Text("login_no".tr),
                    //         );
                    //       });
                    // }
                    showDialog(
                      context: context,
                      builder: (context) => loadingDialog(),
                    );
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
                            color:
                                Config.lang ? Config.maincolor : Colors.black)),
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
                          color: Config.lang ? Colors.black : Config.maincolor),
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

  Widget loadingDialog() {
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
                return AlertDialog(title: Text('login_yes'.tr, style: TextStyle(fontSize: 16), textAlign: TextAlign.center), actions: [
                  TextButton(onPressed: () =>  Navigator.of(context).popAndPushNamed("/home"), child: Text("Enter"))
                ],);
                // Container(
                //   height: 300,
                //   width: 300,
                //   child: Card(
                //     child: Column(children: [
                //       Text('login_yes'.tr),
                //       OutlinedButton(
                //           onPressed: () {
                //             Navigator.of(context).popAndPushNamed("/home");
                //           },
                //           child: Text("enter"))
                //     ]),
                //   ),
                // );
              } else {
                return AlertDialog(title: Text('login_no'.tr, style: TextStyle(fontSize: 16), textAlign: TextAlign.center), actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))
                ],);
                // Container(
                //   margin: EdgeInsets.all(20),
                //   child: Card(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //       Text('login_no'.tr),
                //       OutlinedButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //           },
                //           child: Text("enter"))
                //     ]),
                //   ),
                // );

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
