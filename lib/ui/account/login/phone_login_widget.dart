import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLoginWidget extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          UserCredential result = await _auth.signInWithCredential(credential);
          User user = result.user;
          if (user != null) {
            print("Login Successful!");
            accountBloc.insertUserToDatabase(user);
            Navigator.of(context).pop();
          } else {
            print("Error");
          }
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Vui lòng nhập mã OTP"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("XÁC NHẬN"),
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        UserCredential result =
                            await _auth.signInWithCredential(credential);

                        User user = result.user;

                        if (user != null) {
                          print("Login Successful!");
                          accountBloc.insertUserToDatabase(user);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/illustrations/kingdom-4.png',
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 32),
                    child: Text(
                      "Vui lòng nhập số điện thoại của bạn",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "0967123456"),
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
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
                        var phone = _phoneController.text
                            .trim()
                            .replaceAll(new RegExp(r'^0+(?=.)'), '');
                        if (phone.substring(0, 1) != '84') {
                          phone = "+84" + phone;
                        } else {
                          phone = "+" + phone;
                        }
                        print("LOGIN WITH PHONE: $phone");
                        loginUser(phone, context);
                      },
                      child: Text('GỬI MÃ OTP'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
