import 'dart:convert';
import 'dart:core';
import 'package:e_commerce/Models/Destinatario.dart';
import 'package:e_commerce/Services/PaypalService.dart';
import 'package:e_commerce/Utils/Config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'PaypalService.dart';

class PaypalPayment extends StatefulWidget {
  final Function? onFinish;

  PaypalPayment({this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl = Config.apiURL + Config.checkoutAPI;
  var headers = {'Authorization': Config.token};
  late String executeUrl;
  late String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = componente();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"]!;
            executeUrl = res["executeUrl"]!;
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
      }
    });
  }

  // item name, price and quantity
  String producto = '7';
  String itemPrice = '1.99';
  int cantidad = 1;
  String respaldo = "";

  Map<String, dynamic> componente() {
    List items = [
      {
        "producto": producto,
        "respaldo": respaldo,
        "cantidad": cantidad,
      }
    ];

    // checkout invoice details
    String total = '1.99';
    String subTotal = '1.99';
    int costoEnvio = 0;
    String resumen_pago = "";
    String nombre = 'Paco';
    String ciudad = 'La Habana';
    String direccion = 'La esquina 25';
    String pais = '1';
    String provicia = 'La Habana';
    String telefono = '+53569669';

    Map<String, dynamic> orden = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": total,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotal,
              "shipping": costoEnvio,
              "precio_envio": ((-1.0) * costoEnvio).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "destinatario": jsonEncode(Config.activeDest).replaceAll(r'\"', "'"),
          }
        }
      ],
      "nota": "nota",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return orden;
  }

  @override
  Widget build(BuildContext context) {
    late WebViewController wc;
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          onWebViewCreated: (controller) {
            wc = controller;
          },
          onPageStarted: (checkoutUrl) {
            wc.loadUrl(checkoutUrl, headers: headers);
          },
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish!(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
