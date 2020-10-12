import 'dart:io';

import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  WebViewContainer({Key key, this.url, this.allowFollowLink}) : super(key: key);
  final String url;
  final allowFollowLink;

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
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
        navigationDelegate: (NavigationRequest request) {
          if (!this.widget.allowFollowLink && this.widget.url != request.url) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
      Container(
        color: Colors.white,
        child: Center(child: LoadingWidget()),
      ),
    ]));
  }
}
