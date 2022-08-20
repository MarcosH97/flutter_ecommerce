import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewPage extends StatefulWidget {
  final String url;
  webViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<webViewPage> createState() => _webViewPageState();
}

class _webViewPageState extends State<webViewPage> {
  @override
  Widget build(BuildContext context) {
    late WebViewController wc;
    // print(checkoutUrl);

    if (widget.url != null) {
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
          onPageStarted: (url) {
            wc.loadUrl(url);
          },
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
    } else {
      return Scaffold(
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
