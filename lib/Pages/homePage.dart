import 'package:e_commerce/Pages/foodPageBody.dart';
import 'package:e_commerce/Widgets/glassmorph.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.amber,
          child: FlutterLogo(
            size: 30,
          ),
        ),
        accountName: Text(
          "UserName",
          textScaleFactor: 1,
        ),
        accountEmail: Text("emailtest@email.com"));

    var w = MediaQuery.of(context).size.width;

    final _drawerItems = ListView(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        drawerHeader,
        const ListTile(title: Text('Account')),
        const ListTile(title: Text('Account')),
        const ListTile(title: Text('Account')),
        const ListTile(title: Text('Account')),
        const ListTile(title: Text('Account')),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.account_circle_outlined))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(),
                    Container(
                        width: 45,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                          size: 35,
                        )),
                  ],
                ),
              )),
          foodPageBody(),
          Container(
            child: Text(w.toString()),
          ),
          const Glassmorphism(
              blur: 50,
              opacity: 0.2,
              child: SizedBox(
                height: 200,
                width: 100,
              ))
        ],
      ),
      drawer: Drawer(
        child: _drawerItems,
      ),
    );
  }
}
