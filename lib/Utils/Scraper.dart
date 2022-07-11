import 'package:e_commerce/Models/Producto.dart';
import 'package:http/http.dart' as http;

class Scraper {
  static const URL = 'http://localhost:3000/#';

  static void getData() async {
    final response = await http.get(Uri.parse(URL));

    final body = response.body;

    // final html = parse(body);

    // final title = html.querySelector('.section-title')?.text;

    // final prod_names = html.querySelectorAll('.product_name');

    // print('titulo: $title');
    // if (prod_names.isEmpty) {
    //   print('vacio');
    // }else{
    //   print(prod_names[0].text);
    // }
    // for (var names in prod_names) {
    //   print("nombres: ${names.text.trim()}");
    // }
  }

  // static Future<String> getProducto() async {
  //   final response = await http.get(Uri.parse(""));

  //   final body = response.body;

  //   final html = parse(body);

  //   print(
  //       "html.querySelectorAll('.slick-track img')[1].attributes['src']!.trim()");
  //   return String(
  //       "html.querySelectorAll('.slick-track img')[1].attributes['src']!.trim()",
  //       " ",
  //       " ",
  //       " ");

  //   // html.querySelector('.title-detail')!.text
  //   // html.querySelector('.product-price .text-brand')!.text
  //   // html.querySelector('.product-price .save-price')!.text
  // }

  // static Future<List<String>> getWishlist() async {
  //   final response = await http.get(Uri.parse(""));

  //   final body = response.body;

  //   // // final html = parse(body);

  //   // List<String> s = [];

  //   // int size = html.querySelectorAll('.flex .items-center img').length;
  //   // for (int i = 0; i < size; i++) {
  //   //   s.add(html
  //   //       .querySelectorAll('.flex .items-center img')[i]
  //   //       .attributes['src']!
  //   //       .trim());
  //   // }
  //   return s;
  // }
}
