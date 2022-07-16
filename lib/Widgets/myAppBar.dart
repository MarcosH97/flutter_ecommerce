import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../Utils/Config.dart';
import '../Utils/HeroDialogRoute.dart';
import 'addToPopupCard.dart';

class myAppBar {
  final context;

  myAppBar({required this.context});

  AppBar AppBarM() {

    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Badge(
            badgeContent: Text(
              Config.wishlist.length.toString(),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(HeroDialogRoute(builder: (context) {
                    return AddTodoPopupCard();
                  }));
                },
                icon: Config.wishlist.length>0 ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border_outlined),
                iconSize: 40,
                padding: EdgeInsets.all(0)),
            animationType: BadgeAnimationType.scale,
            showBadge: Config.wishlist.length > 0,
            position: BadgePosition.center(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: 
          Badge(
            badgeContent: Text(Config.carrito.length.toString(),  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/checkout');
              },
              padding: EdgeInsets.all(0),
              icon: const Icon(Icons.shopping_cart_outlined),
              iconSize: 40,
            ),
            animationType: BadgeAnimationType.scale,
            showBadge: Config.carrito.length > 0,
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
