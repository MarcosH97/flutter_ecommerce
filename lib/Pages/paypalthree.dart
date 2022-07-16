import 'dart:convert';

import 'package:e_commerce/Models/Destinatario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import '../Utils/Config.dart';

class PayPalLast extends StatefulWidget {
  PayPalLast({Key? key}) : super(key: key);

  @override
  State<PayPalLast> createState() => _PayPalLastState();
}

class _PayPalLastState extends State<PayPalLast> {
  Destinatario d = Config.destinatarios[Config.destiny];
  String carrito = jsonEncode(Config.carrito).replaceAll(r"\", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: TextButton(
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UsePaypal(
                            sandboxMode: true,
                            clientId:
                                "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                            secretKey:
                                "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                            returnURL: "https://samplesite.com/return",
                            cancelURL: "https://samplesite.com/cancel",
                            transactions: [
                              {
                                "amount": {
                                  "total": '10.12',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '10.12',
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  carrito,

                                  // shipping address is not required though
                                  "shipping_address": {
                                    "recipient_name": d.nombre,
                                    "line1": d.direccion,
                                    "line2": "",
                                    "city": d.ciudad,
                                    "country_code": "US",
                                    "postal_code": "",
                                    "phone": d.telefono,
                                    "state": ""
                                  },
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              print("onError: $error");
                            },
                            onCancel: (params) {
                              print('cancelled: $params');
                            }),
                      ),
                    )
                  },
              child: const Text("Make Payment")),
        ));
  }
}
