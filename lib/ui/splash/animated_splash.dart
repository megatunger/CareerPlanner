import 'package:flutter/material.dart';

class AnimatedSplash extends StatefulWidget {
  AnimatedSplash({Key key, this.message, this.loading}) : super(key: key);
  final String message;
  final bool loading;

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF421872),
      body: Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(backgroundColor: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    '${this.widget.message}',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  )
                ],
              ))),
    );
  }
}
