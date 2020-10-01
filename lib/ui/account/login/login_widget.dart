import 'package:careerplanner/util/router.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Image.asset(
                      'assets/illustrations/flame-training.png',
                    )),
                    Text(
                      'Hãy đăng nhập để ứng dụng có thể đưa ra những tư vấn chính xác hơn nhé!',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 56,
                      child: FlatButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.phoneLoginRoute);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone),
                            SizedBox(width: 8),
                            Text('ĐĂNG NHẬP VỚI SỐ ĐIỆN THOẠI')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ))));
  }
}
