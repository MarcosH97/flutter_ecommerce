import 'package:e_commerce/Widgets/glassmorph.dart';
import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Glassmorphism(
            blur: 20,
            opacity: 0.7,
            child: Column(
              children: [Image(image: AssetImage('assets/logo.png'))],
            ))
      ],
    );
  }
}
