import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Models/Producto.dart';
import 'package:e_commerce/Pages/checkoutPage.dart';
import 'package:e_commerce/Pages/productPage.dart';
import 'package:e_commerce/Pages/userPage.dart';
import 'package:e_commerce/Providers/cartProvider.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:e_commerce/Widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Widgets/MobileWidgets/productsMobile.dart';
import 'filterPage.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late var textController = TextEditingController();
  late List<ProductoMun> filter;
  int selected = 0;

  void callback() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    final _tabs = [
      mainPage(),
      userPage(
        callback: callback,
      ),
      checkOutPage()
    ];
    final _navBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Config.maincolor,
        ),
        label: "home",
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, color: Config.maincolor),
          label: "user"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart, color: Config.maincolor),
          label: "cart"),
    ];
    assert(_tabs.length == _navBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
      items: _navBarItems,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
    int countK = context.watch<Cart>().listaSize;
    return SafeArea(
      child: Scaffold(
        // extendBody: true,
        backgroundColor: Color.fromARGB(255, 23, 31, 56),
        appBar: myAppBar(
          context: context,
          // callback: callback
        ).AppBarM(),
        body: _tabs[currentIndex],
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 91, 131, 160),
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 40,
                    onPressed: () {
                      setState(() {
                        currentIndex = 0;
                        selected = currentIndex;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      color: selected == 0 ? Config.maincolor : Colors.grey,
                    )),
                IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 40,
                    onPressed: () {
                      setState(() {
                        if (Config.isLoggedIn) {
                          currentIndex = 1;
                          selected = currentIndex;
                        } else
                          Navigator.popAndPushNamed(context, '/login');
                      });
                    },
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color: selected == 1 ? Config.maincolor : Colors.grey,
                    )),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Badge(
                    badgeContent: Text("$countK",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    ignorePointer: true,
                    animationType: BadgeAnimationType.scale,
                    showBadge: countK > 0,
                    position: BadgePosition.center(),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 2;
                          selected = currentIndex;
                        });
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: selected == 2 ? Config.maincolor : Colors.grey,
                      ),
                      iconSize: 40,
                    ),
                  ),
                ),
              ],
            )),
        // bottomNavBar,
        drawer: Drawer(
          child: drawerMenuItems(context),
        ),
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
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: 'Aceites',
                                              headerName: "Aceites")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Pomos'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: 'Aceites',
                                              subcat: 'Pomos',
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
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: 'Bebidas',
                                              headerName: "Bebidas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Aguas'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: "Bebidas",
                                              subcat: "Aguas",
                                              headerName: "Aguas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Gaseadas'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: "Bebidas",
                                              subcat: "Gaseadas",
                                              headerName: "Gaseadas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Instantáneas'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: "Bebidas",
                                              subcat: "Instantáneas",
                                              headerName: "Instantáneas")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Jugos'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: 'Jugos',
                                              subcat: 'Bebidas',
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
                          ExpansionTile(
                            title: drawerText('Electrónicos'),
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 77, 22, 18),
                            collapsedBackgroundColor:
                                Color.fromARGB(255, 143, 34, 34),
                            children: [
                              ListTile(
                                title: drawerText('Todas'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: 'Electrónicos',
                                              headerName: "Electrónicos")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Electrodomesticos'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: 'Electrónicos',
                                              subcat: "Electrodomesticos",
                                              headerName:
                                                  "Electrodomesticos")));
                                },
                              ),
                              ListTile(
                                title: drawerText('Piezas de Pc'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: "Electrónicos",
                                              subcat: "Piezas de Pc",
                                              headerName: "Piezas de Pc")));
                                },
                              ),
                            ],
                          ),
                        ]),
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
                          ListTile(
                              title: drawerText("F.A.Q"),
                              onTap: () =>
                                  Navigator.pushNamed(context, '/help')),
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
                                ListTile(
                                    title: Text(
                                  "USD",
                                  style: TextStyle(color: Colors.white),
                                )),
                                // ListTile(
                                //   title: Text("EUR",
                                //       style: TextStyle(color: Colors.white)),
                                // ),
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
                              //13053377539
                              onTap: () async {
                                var wassa =
                                    "whatsapp://send?phone=+5356955024&text=Hola,%20Diplomarket";
                                try {
                                  launchUrl(Uri.parse(wassa),
                                      mode: LaunchMode.externalApplication);
                                } catch (e) {}
                              }),
                          ListTile(
                              title: drawerText("+1 305 26 7330"),
                              leading: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                var wassa =
                                    "whatsapp://send?phone=+13053377539&text=Hola,%20Diplomarket";
                                try {
                                  launchUrl(Uri.parse(wassa),
                                      mode: LaunchMode.externalApplication);
                                } catch (e) {}
                              }),
                          ListTile(
                              title: drawerText("soporte@diplomarket.com"),
                              leading: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                              onTap: () {
                                var uri = Uri(
                                    scheme: 'mailto',
                                    path: 'soporte@diplomarket.com');
                                launchUrl(uri,
                                    mode: LaunchMode.externalApplication);
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
}

class mainPage extends StatefulWidget {
  mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  void initState() {
    super.initState();
    LoadStuff();
  }

  List<DropdownMenuItem<String>> _dropDownCatItems = [];

  List<DropdownMenuItem<String>> _dropDownMenuItems = [];

  @override
  Widget build(BuildContext context) {
    var filter;

    return RefreshIndicator(
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
                      //-----SEARCH BAR-----

                      Expanded(
                        child: Container(
                          // decoration: BoxDecoration(
                          //     // color: Colors.white,
                          //     borderRadius: BorderRadius.only(
                          //         bottomLeft: Radius.circular(10),
                          //         topLeft: Radius.circular(10))),
                          child: TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                                autofocus: false,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.search),
                                    suffixIconColor: Config.maincolor,
                                    filled: true,
                                    focusColor: Config.maincolor,
                                    fillColor: Colors.white,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    label: Text('search'.tr),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Config.maincolor)))),
                            itemBuilder: (context, itemData) => ListTile(
                              title: Text(itemData.toString()),
                            ),
                            onSuggestionSelected: (suggestion) {
                              // filter = await ProductoFiltro().FilteredList(
                              //     key: suggestion.toString(), subkey: null);
                              int z = Config()
                                  .suggestionType(suggestion.toString());
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                // print('Z = $z');
                                switch (z) {
                                  case 1:
                                    {
                                      ProductoMun p =
                                          Config.AllProductsMun.firstWhere(
                                              (element) =>
                                                  element.nombre == suggestion);
                                      return productPage(id: p.id!, index: 0);
                                    }
                                  case 2:
                                    {
                                      return filterPage(
                                          cat: suggestion.toString(),
                                          headerName: "$suggestion");
                                    }
                                  case 3:
                                    {
                                      return filterPage(
                                          subcat: suggestion.toString(),
                                          headerName: "$suggestion");
                                    }
                                  default:
                                    {
                                      return filterPage(
                                          productos: filter,
                                          headerName: "$suggestion");
                                    }
                                }
                              }));
                            },
                            suggestionsCallback: (pattern) async {
                              return await Config().searchBar(pattern);
                            },
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.all(0),
                      //       alignment: Alignment.center,
                      //       primary: Config.maincolor,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(2)),
                      //       fixedSize: Size(30, 60),
                      //     ),
                      //     child: const Icon(
                      //       Icons.search,
                      //       color: Colors.white,
                      //       size: 30,
                      //     ))
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
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Config.maincolor,
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Config.maincolor,
                            value: Config.selectedCar,
                            hint: Text(
                              'categories'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            items: _dropDownCatItems,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              overflow: TextOverflow.visible,
                            ),
                            alignment: Alignment.center,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  // print(newValue);
                                  // filter = await ProductoFiltro()
                                  //     .FilteredList(key: newValue, subkey: null);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => filterPage(
                                              cat: newValue,
                                              headerName: "$newValue")));
                                  // Config.selectedCar = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Config.maincolor,
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
                                  context.read<Cart>().cleanCart();
                                  context.read<Wishlist>().cleanCart();
                                  // Config.carrito.clear();
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
                  height: 10,
                )
              ],
            ),
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    //------BANNER------

                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: PageView.builder(
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                              imageUrl: Config.apiURL +
                                  Config.carrusel[index].imgMovil!,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: LinearProgressIndicator(),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error));
                        },
                        itemCount: Config.carrusel.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),

                    //-----TOP PRODUCTS-----

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
                        id: 1,
                        // callback: callback,
                        axis: Axis.horizontal,
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
                          id: 2,
                          // callback: callback,
                          axis: Axis.horizontal,
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
                          // callback: callback,
                          axis: Axis.horizontal,
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
                          id: 4,
                          // callback: callback,
                          axis: Axis.horizontal,
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      color: Config.secondarycolor,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/logo_large.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "diplomsg".tr,
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
                                  backgroundColor: MaterialStateProperty.all(
                                      Config.maincolor)),
                              child: const Text(
                                "Sobre nosotros",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Config.maincolor)),
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
                                  backgroundColor: MaterialStateProperty.all(
                                      Config.maincolor)),
                              child: const Text(
                                "Términos y Condiciones",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Config.maincolor)),
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
                )),
          ],
        ),
      ),
    );
  }

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
}
