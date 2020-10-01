import 'package:careerplanner/ui/shared/web_view_container.dart';
import 'package:flutter/material.dart';

class AboutUsWidget extends StatefulWidget {
  AboutUsWidget({Key key}) : super(key: key);

  @override
  _AboutUsWidgetState createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Về Ứng Dụng")),
      body: WebViewContainer(
        url: 'https://google.com.vn',
      ),
    );
  }
}
