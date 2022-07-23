
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class PayPage extends StatelessWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                var request = BraintreeDropInRequest(
                    tokenizationKey: "sandbox_tvhccd36_fbgwp5gzcnhcpd9c",
                    amount: '15.00',
                    paypalEnabled: true,
                    collectDeviceData: true,
                    paypalRequest: BraintreePayPalRequest(
                      amount: '15.00',
                      displayName: "DiploMarket",
                    ),
                    cardEnabled: true);
                final result = await BraintreeDropIn.start(request);
                print("result"+result.toString());
                if (result != null) {
                  print('Nonce: ${result.paymentMethodNonce.nonce}');
                  print('Nonce: ${result.paymentMethodNonce.description}');
                } else {
                  print('Selection was canceled.');
                }
              },
              child: Text('Pagar'))
        ],
      ),
    );
  }
}
