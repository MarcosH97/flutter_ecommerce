import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Services/SharedService.dart';
import 'package:e_commerce/Widgets/createDestin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Config.dart';

class userPage extends StatefulWidget {
  Function callback;
  userPage({Key? key, required this.callback}) : super(key: key);

  @override
  State<userPage> createState() => _UserPageState();
}

class _UserPageState extends State<userPage> {
  var _controller = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool _switch = false;

  bool ckbox = false, changes = false;

  bool lang = true;

  var destin = "";

  int _rowperpage = PaginatedDataTable.defaultRowsPerPage;

  late List<DropdownMenuItem<String>> _destinos;

  Future<void> getlogin() async {
    var sh = await SharedPreferences.getInstance();
    bool b = sh.getBool('login')!;
    print(b);
  }

  @override
  Widget build(BuildContext context) {
    if (Config.destinos.length > 0) {
      destin = Config.destinos[Config.destinIndex];
      // print(Config.destinos);
      _destinos = Config.destinos
          .map((String value) => DropdownMenuItem<String>(
                child: Center(child: Text(value, textAlign: TextAlign.center)),
                value: value,
              ))
          .toList();
    } else {
      _destinos = [];
      setState(() {
        _switch = true;
      });
    }
    Destinatario d = Destinatario();
    lang = Config.lang;
    getlogin();
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          Config().LoadUserData();
        });
      },
      child: SingleChildScrollView(
          child: Column(children: [
        Container(
            color: Config.maincolor,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              ExpansionTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  collapsedBackgroundColor: Config.maincolor,
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
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
                          SizedBox(
                            height: 10,
                          ),
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
                            title: Text(
                                "${'country'.tr}: " + Config.activeUser.pais!),
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
                          SizedBox(
                            height: 10,
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

              //-----DESTINATARIOS-----

              ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: Text('destins'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.person_add, color: Colors.white),
                  backgroundColor: Config.maincolor,
                  collapsedBackgroundColor: Config.maincolor,
                  children: [
                    if (Config.destinatarios.isNotEmpty)
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            dropdownColor: Colors.white,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Config.maincolor,
                              overflow: TextOverflow.visible,
                            ),
                            isExpanded: true,
                            itemHeight: null,
                            value: destin,
                            alignment: Alignment.center,
                            items: _destinos,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Config.maincolor,
                            ),
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() {
                                  destin = value;
                                  // print(destin);
                                  Config().setDestinIndexes(value);
                                });
                              }
                            },
                          ))),
                    Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Text(
                              'createdest'.tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            createDestin(callback: (){}),
                          ],
                        ))
                  ]),

              //-----ORDERS-----

              ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: Text('orders'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
                leading: Icon(Icons.list_alt, color: Colors.white),
                backgroundColor: Config.maincolor,
                collapsedBackgroundColor: Config.maincolor,
                children: [
                  Container(
                    height: 300,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Pasarela')),
                              DataColumn(label: Text('ID de Orden')),
                              DataColumn(label: Text('Estado')),
                              DataColumn(label: Text('Fecha de compra')),
                            ],
                            rows: Config().getOrdenes(),
                          )),
                    ),
                  )
                ],
              ),

              //-----SETTINGS-----

              ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
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
                      child: changePass()),
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
                                color: lang ? Config.maincolor : Colors.black)),
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
              ),
            ])),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              SharedService().ClearData();
              Config.login = false;
              // Navigator.popAndPushNamed(context, "/home");
              widget.callback();
            },
            child: Text(
              "close".tr,
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
        ),
      ])),
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

  // Widget dataTable() => PaginatedDataTable(
  //     header: Text('orders'.tr), columns: KtableColumns, source: );

  var KtableColumns = <DataColumn>[
    DataColumn(label: Text('payment'.tr)),
    DataColumn(label: Text('status'.tr)),
    DataColumn(label: Text('purchase'.tr), numeric: true),
    DataColumn(label: Text('date'.tr)),
  ];
}

class changePass extends StatefulWidget {
  changePass({Key? key}) : super(key: key);

  @override
  State<changePass> createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  String oldpw = '', newpw = '';

  final _globalKey = GlobalKey<FormState>();

  String? ValidateNPW(String? s) {
    if (s!.length == 0) {
      return "Campo vacio";
    } else if (Config.currentPW == s) {
      return "Las contraseñas son iguales";
    } else if (s.length < 8) {
      return "Contraseña demasiado corta";
    }
    return null;
  }

  String? ValidateOPW(String? s) {
    if (s!.length == 0) {
      return "Campo vacio";
    } else if (Config.currentPW != s) {
      return "Contraseña incorrecta";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'pw_old'.tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: ValidateOPW,
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: ValidateNPW,
            decoration: InputDecoration(
                focusColor: Config.maincolor,
                border: OutlineInputBorder(),
                fillColor: Colors.white),
            obscureText: true,
            onSaved: (newValue) {
              newpw = newValue ?? '';
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                  print('validated');
                  if (await Config.user.changePassword(newpw)) {
                    Config.currentPW = newpw;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text('Cambiada exitosamente'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Ok"))
                          ]),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text('Hubo un error'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Ok"))
                          ]),
                    );
                  }
                }
              },
              child: Text(
                'chg_pw'.tr,
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Config.maincolor,
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }
}
