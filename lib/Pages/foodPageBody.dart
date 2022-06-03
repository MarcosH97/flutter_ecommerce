import 'package:flutter/material.dart';

import '../Utils/Device.dart';
import '../Widgets/glassmorph.dart';

class foodPageBody extends StatefulWidget {
  foodPageBody({Key? key}) : super(key: key);

  @override
  State<foodPageBody> createState() => _foodPageBodyState();
}

class _foodPageBodyState extends State<foodPageBody> {
  @override
  Widget build(BuildContext context) {
    double wid = Device().isMobile(context) ? 400 : 500;
    return Container(
        height: Device().isMobile(context) ? 300 : 400,
        width: wid,
        child: PageView.builder(
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            }));
  }

  Widget _buildPageItem(int pos) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.amber),
          ),
          const Glassmorphism(
              blur: 30,
              opacity: 0.6,
              child: SizedBox(
                height: 100,
                width: 400,
                child: Text('15.99',
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    textScaleFactor: 2,
                    textWidthBasis: TextWidthBasis.parent),
              ))
        ],
      ),
    );
  }
}
