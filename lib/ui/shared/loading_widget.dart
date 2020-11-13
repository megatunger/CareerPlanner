import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget({Key key, this.backgroundColor}) : super(key: key);
  final Color backgroundColor;
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: (this.widget.backgroundColor != null)
            ? this.widget.backgroundColor
            : Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(128.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElasticIn(
                    animate: true,
                    child: Image.asset(
                      "assets/icon/ICON_CIRCLE.png",
                    )),
                SizedBox(height: 64),
                LinearProgressIndicator()
              ],
            ),
          ),
        ));
  }
}
