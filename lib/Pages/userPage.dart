import 'package:e_commerce/Services/SharedService.dart';
import 'package:e_commerce/Widgets/addToPopupCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Config.dart';
import '../Utils/HeroDialogRoute.dart';
import '../Widgets/myAppBar.dart';

class userPage extends StatefulWidget {
  userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _UserPageState();
}

class _UserPageState extends State<userPage> {
  final GlobalKey<FormFieldState> _globalKey = GlobalKey<FormFieldState>();
  var _controller = TextEditingController();

  String oldpw = '', newpw = '';
  bool ckbox = false, changes = false;
  bool lang = true;

  Future<void> getlogin() async {
    var sh = await SharedPreferences.getInstance();
    bool b = sh.getBool('login')!;
    print(b);
  }

  @override
  Widget build(BuildContext context) {
    lang = Config.lang;
    getlogin();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            color: Config.maincolor,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ExpansionTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    collapsedBackgroundColor: Config.maincolor,
                    collapsedIconColor: Colors.white,
                    childrenPadding: EdgeInsets.symmetric(horizontal: 10),
                    initiallyExpanded: true,
                    backgroundColor: Config.maincolor,
                    title: Text(
                      'user_data'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                                tileColor: Colors.white,
                                title: Text(
                                    "${"name".tr}: ${Config.activeUser.name!}"),
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => alertBuilder(
                                          'name'.tr,
                                        ))),
                            divider(),
                            ListTile(
                              title: Text(
                                  "${'email'.tr}: " + Config.activeUser.email!),
                            ),
                            divider(),
                            ListTile(
                              title: Text("${'address'.tr}: " +
                                  Config.activeUser.direccion!),
                            ),
                            divider(),
                            ListTile(
                              title: Text("${'country'.tr}: " +
                                  Config.activeUser.pais!),
                            ),
                            divider(),
                            ListTile(
                              title: Text(
                                  "${'city'.tr}: " + Config.activeUser.ciudad!),
                            ),
                            divider(),
                            ListTile(
                              title: Text("${'zipcode'.tr}: " +
                                  Config.activeUser.codigoPostal!),
                            ),
                            divider(),
                            ListTile(
                              title: Text("${'phone'.tr}: " +
                                  Config.activeUser.telefono!),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            activeColor: Colors.white,
                            checkColor: Config.maincolor,
                            value: ckbox,
                            onChanged: (value) {
                              setState(() {
                                ckbox = !ckbox;
                              });
                            },
                          ),
                          Text(
                            'notify'.tr,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: changes ? () {} : null,
                        child: Text('chg_sv'.tr,
                            style: TextStyle(color: Config.maincolor)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: Size(200, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
                ExpansionTile(
                  title: Text('destins'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.person_add, color: Colors.white),
                  backgroundColor: Config.maincolor,
                  collapsedBackgroundColor: Config.maincolor,
                  children: [],
                ),
                ExpansionTile(
                  title: Text('orders'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.list_alt, color: Colors.white),
                  backgroundColor: Config.maincolor,
                  collapsedBackgroundColor: Config.maincolor,
                  children: [],
                ),
                ExpansionTile(
                  title: Text('settings'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.settings, color: Colors.white),
                  backgroundColor: Config.maincolor,
                  collapsedBackgroundColor: Config.maincolor,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Form(
                          key: _globalKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'pw_old'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    focusColor: Config.maincolor,
                                    border: OutlineInputBorder(),
                                    fillColor: Colors.white),
                                obscureText: true,
                                onSaved: (newValue) {
                                  oldpw = newValue ?? '';
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'pw_new'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    focusColor: Config.maincolor,
                                    border: OutlineInputBorder(),
                                    fillColor: Colors.white),
                                obscureText: true,
                                onSaved: (newValue) {
                                  newpw = newValue ?? '';
                                },
                              ),
                            ],
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'chg_pw'.tr,
                        style: TextStyle(color: Config.maincolor),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'lang'.tr,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Wrap(
                      children: [
                        ActionChip(
                          backgroundColor: lang ? Colors.white : Colors.grey,
                          label: Text('Esp',
                              style: TextStyle(
                                  color:
                                      lang ? Config.maincolor : Colors.black)),
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
                        ActionChip(
                          label: Text(
                            'Eng',
                            style: TextStyle(
                                color: lang ? Colors.black : Config.maincolor),
                          ),
                          backgroundColor: lang ? Colors.grey : Colors.white,
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
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                SharedService().ClearData();
                Config.login = false;
                Navigator.popAndPushNamed(context, "/home");
              },
              child: Text(
                "Cerrar cuenta",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(200, 60)),
                backgroundColor: MaterialStateProperty.all(Config.maincolor),
              )),
          SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }

  AlertDialog alertBuilder(name) => AlertDialog(
        title: Text('${'new'.tr} $name'),
        content: TextField(
          controller: _controller,
          onChanged: (value) {},
        ),
      );

  ChangeFieldData(name, field) {
    switch (field) {
      case 1:
        {
          break;
        }
      case 2:
        {
          break;
        }
      case 3:
        {
          break;
        }
      default:
        {
          break;
        }
    }
  }

  Widget divider() => Container(
      color: Colors.white,
      child: Divider(
        indent: 10,
        endIndent: 10,
        color: Config.maincolor,
      ));
}
