import 'package:flutter/material.dart';

import '../Utils/Config.dart';

class helpPage extends StatelessWidget {
  const helpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: Config.faqs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ExpansionTile(
                    title: Text(Config.faqs[index].pregunta!),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(Config.faqs[index].respuesta!, textAlign: TextAlign.justify,  style: TextStyle(),),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  )
                ],
              );
            }),
      ),
    );
  }
}
