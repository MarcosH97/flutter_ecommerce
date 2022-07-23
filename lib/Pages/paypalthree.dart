import 'dart:convert';
import 'package:e_commerce/Models/Carrito.dart';
import 'package:http/http.dart' as http;
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
  // Destinatario d = Config.destinatarios
  //     .where((element) => (element.id == Config.destiny))
  //     .first;
  Destinatario d = Config.destinatarios[0];

  @override
  Widget build(BuildContext context) {
    print('total: ' +
        (Config().getTotalPriceKart() + Config().getCostActiveMun())
            .toString());
    print('subtotal: ' + Config().getTotalPriceKart().toString());
    print('envio: ' + Config().getCostActiveMun().toString());

    return paypalW();
  }

  Widget testWidget() {
    // String carrito = jsonEncode(Config.carrito).replaceAll(r'\"', "'");
    // carrito = carrito.replaceAll('"', '');
    // print(carrito);
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
                                "AQ855mfu8YyVl3z7H9Imj18qQlVhMEXfA5l7S9T8E23-P4V-tAazlzTbFfHSXgTsCV_HD5uAiErGrPVy",
                            secretKey:
                                "EDteVGW56u7lH-WmfpdkeHxd1m0G7ddx3i3-PrS56ixdEEyJqt4PnQG2h45xUJdsTFXxrq4OyRhFSNOK",
                            returnURL: "https://samplesite.com/return",
                            cancelURL: "https://samplesite.com/cancel",
                            transactions: [
                              {
                                "amount": {
                                  "total": (Config().getTotalPriceKart() +
                                          Config().getCostActiveMun())
                                      .toString(),
                                  "currency": Config.currency,
                                  "details": {
                                    "subtotal":
                                        Config().getTotalPriceKart().toString(),
                                    "shipping": Config().getCostActiveMun(),
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                    "The payment transaction description.",
                                "item_list": {
                                  "items": [
                                    {
                                      "name": Config()
                                          .getProductoLocal(Config.carrito[0])
                                          .nombre!,
                                      "quantity": Config.carrito[0].cantidad!
                                          .toString(),
                                      "price": Config()
                                          .getProductoLocal(Config.carrito[0])
                                          .precio!
                                          .cantidad!,
                                      "currency": Config.currency
                                    },
                                  ],
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) {
                              print("onSuccess: $params");
                              Config().reducirInventario();
                              Navigator.pop(context);
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

  Widget paypalW() => UsePaypal(
      sandboxMode: true,
      clientId:
          "AQ855mfu8YyVl3z7H9Imj18qQlVhMEXfA5l7S9T8E23-P4V-tAazlzTbFfHSXgTsCV_HD5uAiErGrPVy",
      secretKey:
          "EDteVGW56u7lH-WmfpdkeHxd1m0G7ddx3i3-PrS56ixdEEyJqt4PnQG2h45xUJdsTFXxrq4OyRhFSNOK",
      returnURL: "https://samplesite.com/return",
      cancelURL: "https://samplesite.com/cancel",
      transactions: [
        {
          "amount": {
            "total":
                (Config().getTotalPriceKart() + Config().getCostActiveMun())
                    .toString(),
            "currency": Config.currency,
            "details": {
              "subtotal": Config().getTotalPriceKart().toString(),
              "shipping": Config().getCostActiveMun(),
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          "item_list": Config().addToCarritoPaypal().toMap()
          // {
          //   "items": [
          //     {"name": "niom", "quantity": "", "price": "", "currency": ""},
          //   ]
          // }
          //  {
          //       "name": Config().getProductoLocal(Config.carrito[0]).nombre!,
          //       "quantity": Config.carrito[0].cantidad!.toString(),
          //       "price": Config()
          //           .getProductoLocal(Config.carrito[0])
          //           .precio!
          //           .cantidad!,
          //       "currency": Config.currency
          //     },
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) {
        print("onSuccess: $params");
        Config().reducirInventario();
        // Navigator.pop(context);
      },
      onError: (error) {
        print("onError: $error");
      },
      onCancel: (params) {
        print('cancelled: $params');
      });

  Widget mainWidget() {
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
                                  "total": '120',
                                  "currency": Config.currency,
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
                                  "items": "",
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
