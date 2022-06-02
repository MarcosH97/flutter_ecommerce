import 'package:flutter/material.dart';

class foodPageBody extends StatefulWidget {
  foodPageBody({Key? key}) : super(key: key);

  @override
  State<foodPageBody> createState() => _foodPageBodyState();
}

class _foodPageBodyState extends State<foodPageBody> {
  @override
  Widget build(BuildContext context) {
    double w = 400;
    if (MediaQuery.of(context).size.width > 600) {
      w = 500;
    }

    return Container(
        height: 250,
        width: w,
        child: PageView.builder(
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            }));
  }

  Widget _buildPageItem(int pos) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.amber),
    );
  }
}
