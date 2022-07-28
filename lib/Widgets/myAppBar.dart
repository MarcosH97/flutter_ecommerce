import 'package:badges/badges.dart';
import 'package:e_commerce/Models/payload.dart';
import 'package:e_commerce/Providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/Config.dart';
import '../Utils/HeroDialogRoute.dart';
import 'addToPopupCard.dart';

class myAppBar {
  final BuildContext context;
  // final Function callback;
  myAppBar({
    required this.context,
    // required this.callback
  });

  AppBar AppBarM() {
    int count = context.watch<Wishlist>().listaSize;
    int countK = context.watch<Cart>().listaSize;
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Badge(
            badgeContent: Text(
              "$count",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            ignorePointer: true,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(HeroDialogRoute(builder: (context) {
                    return AddTodoPopupCard();
                  }));
                },
                icon: count > 0
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_border_outlined),
                iconSize: 40,
                padding: EdgeInsets.all(0)),
            animationType: BadgeAnimationType.scale,
            showBadge: count > 0,
            position: BadgePosition.center(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Badge(
            badgeContent: Text("$countK",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
              padding: EdgeInsets.all(0),
              icon: const Icon(Icons.shopping_cart_outlined),
              iconSize: 40,
            ),
            ignorePointer: true,
            animationType: BadgeAnimationType.scale,
            showBadge: countK > 0,
            position: BadgePosition.center(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              onPressed: () {
                Config.isLoggedIn
                    ? Navigator.pushNamed(context, '/user')
                    : Navigator.popAndPushNamed(context, '/login');
              },
              padding: EdgeInsets.all(0),
              icon: Config.isLoggedIn
                  ? Icon(
                      Icons.account_circle,
                      color: Config.maincolor,
                      size: 40,
                    )
                  : Icon(
                      Icons.account_circle_outlined,
                      size: 40,
                    )),
        ),
      ],
    );
  }
}
