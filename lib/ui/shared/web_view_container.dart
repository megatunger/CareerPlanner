import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  WebViewContainer({Key key, this.url}) : super(key: key);
  final String url;
  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: position, children: <Widget>[
      WebView(
        initialUrl: this.widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        key: key,
        onPageFinished: doneLoading,
        onPageStarted: startLoading,
      ),
      Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      ),
    ]));
  }
}
