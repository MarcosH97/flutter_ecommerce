import 'dart:ui';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Utils/Responsive.dart';
import 'package:e_commerce/Widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../Models/Carrito.dart';
import '../Models/MunicipioModelResponse.dart';
import '../Widgets/DesktopWidgets/productDesktop.dart';
import '../Widgets/MobileWidgets/productsMobile.dart';
import 'filterPage.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late var textController = TextEditingController();
  late List<ProductoAct> filter;
  // Future openDialog() => showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //           title: Text('Nuevo IP'),
  //           content: TextField(
  //             controller: textController,
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () async {
  //                 SharedPreferences sh = await SharedPreferences.getInstance();
  //                 Config.apiURL = "http://${textController.text}:8000";
  //                 sh.setString("ip", Config.apiURL);
  //                 setState(() {
  //                   Config().setAll();
  //                 });
  //                 Navigator.pop(context);
  //               },
  //               child: Text('SUBMIT'),
  //             )
  //           ],
  //         ));
  List<DropdownMenuItem<String>> _dropDownCatItems = [];
  List<DropdownMenuItem<String>> _dropDownMenuItems = [];

  @override
  void initState() {
    super.initState();
    LoadStuff();
  }

  void LoadStuff() {
    setState(() {
      if (Config.munNames.isNotEmpty) {
        _dropDownMenuItems = Config.munNames
            .map((String value) => DropdownMenuItem<String>(
                  child:
                      Center(child: Text(value, textAlign: TextAlign.center)),
                  value: value,
                ))
            .toList();
      }
      Config().setAll();
      _dropDownCatItems = Config.categorias
          .map((String value) => DropdownMenuItem<String>(
                child: Center(child: Text(value, textAlign: TextAlign.center)),
                value: value,
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var drawerHeader = UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(Icons.person, size: 50),
        ),
        accountName: Config.isLoggedIn
            ? Text(
                Config.user.name!,
                textScaleFactor: 1,
              )
            : Text(
                "<No User>",
                textScaleFactor: 1,
              ),
        accountEmail: Config.isLoggedIn
            ? Text(Config.activeUser.email!)
            : Text("no email"));

    var w = MediaQuery.of(context).size.width;

    final _drawerItems = ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('account'.tr),
          onTap: () {
            Config.isLoggedIn
                ? Navigator.pushNamed(context, '/user')
                : Navigator.popAndPushNamed(context, '/login');
          },
        ),
        ListTile(
          title: Text('all_products'.tr),
          onTap: () {
            Navigator.of(context).pushNamed('/allproducts');
          },
        ),
        ExpansionTile(title: Text('help'), children: [
          ListTile(
            title: Text("F.A.Q"),
          ),
          ListTile(
            title: Text("¿Cómo usar Diplomarket?"),
          ),
        ]),
        ListTile(title: Text('to_know'.tr)),
        ExpansionTile(title: Text('contact'.tr), children: []),
        ListTile(
            title: Text('Pagar'),
            onTap: () {
              Navigator.pushNamed(context, '/paypal');
            }),
        ListTile(
            title: Text('Pagar Braintree'),
            onTap: () {
              Navigator.pushNamed(context, '/braintree');
            }),
      ],
    );

    return Scaffold(
      appBar: myAppBar(context: context).AppBarM(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            LoadStuff();
          });
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 50,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            autofocus: false,
                            maxLines: 1,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'carne',
                                labelText: 'search'.tr),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.center,
                              primary: Config.maincolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                              fixedSize: Size(30, 60),
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // Expanded(
                        //     child: Container(
                        //   padding: EdgeInsets.all(5),
                        //   decoration: BoxDecoration(
                        //       border: Border.all(width: 1, color: Colors.grey),
                        //       color: Config.maincolor,
                        //       borderRadius: BorderRadius.circular(5)),
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButton(
                        //       dropdownColor: Config.maincolor,
                        //       value: Config.selectedCar,
                        //       hint: Text(
                        //         'categories'.tr,
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       items: _dropDownCatItems,
                        //       icon: Icon(
                        //         Icons.arrow_forward_ios,
                        //         color: Colors.white,
                        //       ),
                        //       style: const TextStyle(
                        //         fontSize: 16,
                        //         color: Colors.white,
                        //         overflow: TextOverflow.visible,
                        //       ),
                        //       alignment: Alignment.center,
                        //       onChanged: (String? newValue) {
                        //         if (newValue != null) {
                        //           setState(() {
                        //             Config.selectedCar = newValue;
                        //           });
                        //         }
                        //       },
                        //     ),
                        //   ),
                        // )),
                        
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Config.maincolor,
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Config.maincolor,
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              isExpanded: true,
                              itemHeight: null,
                              items: _dropDownMenuItems,
                              value: Config.selectedMun,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                overflow: TextOverflow.visible,
                              ),
                              alignment: Alignment.center,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    Config.selectedMun = newValue;
                                    Config().setActiveMunIndex();
                                  });
                                }
                              },
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'top_products'.tr,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 500,
                child: ProductsMobile(
                  id: 3,
                  mun: 1,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'top_selling'.tr,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: ProductsMobile(
                    id: 3,
                    mun: 1,
                  )),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'recommended'.tr,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: ProductsMobile(
                    id: 3,
                    mun: 1,
                  )),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'in_offer'.tr,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: ProductsMobile(
                    id: 3,
                    mun: 1,
                  )),
              SizedBox(
                height: 24,
              ),
              Container(
                color: Config.secondarycolor,
                child: Column(children: [
                  Image.asset('assets/logo_large.png', fit: BoxFit.contain),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Diplomarket is a division of the Las Americas TCC, LLC. We are very proud to say that Diplomarket is one of the first American Companies to serve the purchase and logistic needs to customers between US and Cuba.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: "Arial",
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "INFORMACIÓN",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Config.maincolor)),
                        child: const Text(
                          "Sobre nosotros",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Config.maincolor)),
                        child: const Text(
                          "Políticas de Privacidad",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Config.maincolor)),
                        child: const Text(
                          "Términos y Condiciones",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Config.maincolor)),
                        child: const Text(
                          "Contáctenos",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          child: ClipRRect(
                              child: Image.asset(
                            "assets/paypal.png",
                            fit: BoxFit.fitWidth,
                          )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 50,
                          child: ClipRRect(
                              child: Image.asset(
                            "assets/tropi.png",
                            fit: BoxFit.fitWidth,
                          )),
                        ),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "© 2022 Diplomarket Cuba Embassies All rights reserved.",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: drawerMenuItems(context),
      ),
    );
  }

  Widget drawerHeader(context) => Container(
        height: MediaQuery.of(context).size.height / 5,
        alignment: Alignment.bottomCenter,
        color: Colors.white,
        child: Image.asset('assets/logo.png'),
      );

  Widget drawerMenuItems(context) => Column(
        children: [
          drawerHeader(context),
          Expanded(
            child: Container(
              color: Config.maincolor,
              child: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 14,
                  children: [
                    ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        title: drawerText(
                          'categories'.tr,
                        ),
                        children: [
                          ExpansionTile(
                            title: drawerText('Aceites'),
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 77, 22, 18),
                            collapsedBackgroundColor:
                                Color.fromARGB(255, 143, 34, 34),
                            children: [
                              ListTile(
                                title: drawerText('Todas'),
                                onTap: () async {
                                  filter = await ProductoFiltro()
                                      .FilteredList("Aceites", null);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              productos: filter,
                                              headerName: "Aceites")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Pomos'),
                                onTap: () async {
                                  filter = await ProductoFiltro()
                                      .FilteredList("Aceites", "Pomos");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              productos: filter,
                                              headerName: "Pomos")));
                                },
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: drawerText('Bebidas'),
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 77, 22, 18),
                            collapsedBackgroundColor:
                                Color.fromARGB(255, 143, 34, 34),
                            children: [
                              ListTile(
                                title: drawerText('Todas'),
                                onTap: () async {
                                  filter = await ProductoFiltro()
                                      .FilteredList("Bebidas", null);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              productos: filter,
                                              headerName: "Bebidas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Aguas'),
                                onTap: () async {
                                  filter = await ProductoFiltro()
                                      .FilteredList("Bebidas", "Aguas");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              productos: filter,
                                              headerName: "Aguas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Gaseadas'),
                                onTap: () async {
                                  filter = await ProductoFiltro()
                                      .FilteredList("Bebidas", "Gaseadas");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              productos: filter,
                                              headerName: "Gaseadas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Instantáneas'),
                                onTap: () async {
                                  filter = await ProductoFiltro()
                                      .FilteredList("Bebidas", "Instantáneas");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              productos: filter,
                                              headerName: "Instantáneas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Jugos'),
                                onTap: () async {
                                  await ProductoFiltro()
                                      .FilteredList("Bebidas", "Jugos");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              productos: filter,
                                              headerName: "Jugos")));
                                },
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: drawerText('Carnes'),
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 77, 22, 18),
                            collapsedBackgroundColor:
                                Color.fromARGB(255, 143, 34, 34),
                            children: [],
                          ),
                        ]),
                    ListTile(
                      title: drawerText('account'.tr),
                      onTap: () {
                        Config.isLoggedIn
                            ? Navigator.pushNamed(context, '/user')
                            : Navigator.popAndPushNamed(context, '/login');
                      },
                    ),
                    ListTile(
                      title: drawerText('all_products'.tr),
                      onTap: () {
                        Navigator.of(context).pushNamed('/allproducts');
                      },
                    ),
                    ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        title: drawerText('help'.tr),
                        children: [
                          ListTile(title: drawerText("F.A.Q"), onTap: () => Navigator.pushNamed(context, '/help')),
                          ListTile(title: drawerText('how_to'.tr)),
                        ]),
                    ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        title: drawerText('settings'.tr),
                        children: [
                          ExpansionTile(
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 77, 22, 18),
                            collapsedBackgroundColor:
                                Color.fromARGB(255, 143, 34, 34),
                            title: drawerText('lang'.tr),
                            children: [
                              ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/es.png'),
                                ),
                                title: drawerText('ESP'),
                                onTap: () {
                                  setState(() {
                                    Get.updateLocale(Locale('es', 'ES'));
                                  });
                                },
                              ),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('assets/us.png'),
                                  ),
                                  title: drawerText('ENG'),
                                  onTap: () {
                                    setState(() {
                                      Get.updateLocale(Locale('en', 'US'));
                                    });
                                  }),
                            ],
                          ),
                          ExpansionTile(
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              backgroundColor: Color.fromARGB(255, 77, 22, 18),
                            collapsedBackgroundColor:
                                Color.fromARGB(255, 143, 34, 34),
                              title: drawerText('currency'.tr),
                              children: [
                                ListTile(title: Text("USD",style: TextStyle(color: Colors.white),)),
                                ListTile(title: Text("EUR",style: TextStyle(color: Colors.white)),),
                              ]),
                        ]),
                    ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        title: drawerText('contact'.tr),
                        children: [
                          ListTile(
                              title: drawerText("+53 54024747"),
                              leading: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: "53 54024747"));
                                Fluttertoast.showToast(
                                    msg: 'cclip'.tr,
                                    gravity: ToastGravity.BOTTOM);
                                // Toast.show('cclip'.tr, duration: Toast.lengthShort, gravity: Toast.bottom);
                              }),
                          ListTile(
                              title: drawerText("+1 305 26 7330"),
                              leading: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: "1 305 26 7330"));
                                Fluttertoast.showToast(
                                    msg: 'cclip'.tr,
                                    gravity: ToastGravity.BOTTOM);
                              }),
                          ListTile(
                              title: drawerText("sales@lasamericastcc.com"),
                              leading: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: "sales@lasamericastcc.com"));
                                Fluttertoast.showToast(
                                    msg: 'cclip'.tr,
                                    gravity: ToastGravity.BOTTOM);
                              }),
                          ListTile(
                              title: drawerText("info@lasamericastcc.com"),
                              leading: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: "info@lasamericastcc.com"));
                                Fluttertoast.showToast(
                                    msg: 'cclip'.tr,
                                    gravity: ToastGravity.BOTTOM);
                              }),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget drawerText(String text) => Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
            letterSpacing: 2),
      );

  Widget products(index) {
    return Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
    );
  }
}
