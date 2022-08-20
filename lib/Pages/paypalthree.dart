import 'package:e_commerce/Models/payload.dart';
import 'package:e_commerce/Pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

import '../Utils/Config.dart';

class PayPalLast extends StatefulWidget {
  PayPalLast({Key? key}) : super(key: key);

  @override
  State<PayPalLast> createState() => _PayPalLastState();
}

class _PayPalLastState extends State<PayPalLast> {
  @override
  Widget build(BuildContext context) {
    // print('total: ' +
    //     (Config().getTotalPriceKart() + Config().getCostActiveMun())
    //         .toString());
    // print('subtotal: ' + Config().getTotalPriceKart().toString());
    // print('envio: ' + Config().getCostActiveMun().toString());
    print(
      Config().addToCarritoPaypal().toMap()
    );

    return paypalW();
  }

  Widget paypalW() => UsePaypal(
      sandboxMode: false,
      clientId:
          "AboFdw8-xPtiKNZDS3nCqZHycaVeAW-cgMpWSl4pD61Eqd4O24TNRDEEztwFnGEuiAIohqqZLRTUqc79",
          // "AQ855mfu8YyVl3z7H9Imj18qQlVhMEXfA5l7S9T8E23-P4V-tAazlzTbFfHSXgTsCV_HD5uAiErGrPVy",
      secretKey:
          "EF2NlhK9fPweC-WUN7lXt0_X_nMFBlcYnvB6iDYxJdG5-tMTqqz3y1IbvHoersJIkjILnjuuh6pYkF1T",
          // "EDteVGW56u7lH-WmfpdkeHxd1m0G7ddx3i3-PrS56ixdEEyJqt4PnQG2h45xUJdsTFXxrq4OyRhFSNOK",
      returnURL: "https://samplesite.com/return",
      cancelURL: "https://samplesite.com/cancel",
      transactions: [
        {
          "amount": {
            "total":
                (Config().getTotalPriceKart(context: context) + Config().getCostActiveMun())
                    .toString(),
            "currency": Config.currency,
            "details": {
              "subtotal": Config().getTotalPriceKart(context: context).toString(),
              "shipping": Config().getCostActiveMun(),
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          "item_list": Config().addToCarritoPaypal().toMap(),
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) {
        Payload()
            .sendPayload2(params['status'], params['data']['links'][0]['href']);
        // Clipboard.setData(ClipboardData(text: "$params"));
        // print("onSuccess: $params");
        print(params['data']['links'][0]['href']);
        Config().reducirInventario();
        
        // Navigator.pop(context);
      },
      onError: (error) {
        print("onError: $error");
      },
      onCancel: (params) {
        print('cancelled: $params');
      });
}
