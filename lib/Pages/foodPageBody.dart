import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Utils/Device.dart';
import '../Widgets/glassmorph.dart';

class foodPageBody extends StatefulWidget {
  foodPageBody({Key? key}) : super(key: key);

  @override
  State<foodPageBody> createState() => _foodPageBodyState();
}

class _foodPageBodyState extends State<foodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);

  List<String> imagesURL = [
    "https://source.unsplash.com/featured/?vase",
    "https://source.unsplash.com/featured/?lamp",
    "https://source.unsplash.com/featured/?macbook",
    "https://source.unsplash.com/featured/?iphone",
    "https://source.unsplash.com/featured/?vacuum,cleaner"
  ];

  @override
  Widget build(BuildContext context) {
    double wid = Device().isMobile(context) ? 400 : 500;
    return Container(
        height: Device().isMobile(context) ? 300 : 400,
        width: wid,
        child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position, context);
            }));
  }

  Widget _buildPageItem(int pos, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imagesURL[pos],
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : Container(
                            width: 50,
                            height: 50,
                            child: const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.blue)),
                          );
                  },
                  errorBuilder: (context, error, stacktrace) {
                    return const Icon(
                      Icons.error,
                      size: 50,
                      color: Colors.grey,
                    );
                  },
                )),
          ),
          const Glassmorphism(
              blur: 50,
              opacity: 0.3,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: SizedBox(
                height: 100,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "data",
                        style: TextStyle(fontSize: 24),
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}
