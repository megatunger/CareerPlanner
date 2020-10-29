import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/account/account_object.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class PhoneVerifyWidget extends StatefulWidget {
  PhoneVerifyWidget({Key key, this.account}) : super(key: key);
  final AccountObject account;

  @override
  _PhoneVerifyWidgetState createState() => _PhoneVerifyWidgetState();
}

class _PhoneVerifyWidgetState extends State<PhoneVerifyWidget> {
  final firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String message =
      'Chúng tôi vừa gửi bạn một mã OTP để xác nhận số điện thoại này. Vui lòng nhập mã OTP ở dưới.';
  bool verifyAble = true;
  String actualCode;
  String otp;

  @override
  void initState() {
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: this.widget.account.phone,
        timeout: Duration(seconds: 120),
        verificationCompleted: (credential) {},
        verificationFailed: (FirebaseAuthException exception) {
          print('OTP verify failed: ${exception.message}');
          setState(() {
            message = 'Có lỗi xảy ra: ${exception.message}';
            verifyAble = false;
          });
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          actualCode = verificationId;
          print('OTP sent: $actualCode');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('OTP timeout');
          setState(() {
            message = 'Hết thời gian nhập mã OTP.';
            verifyAble = false;
          });
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận số điện thoại'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message),
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: "otp",
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Mã OTP"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Đóng'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        if (verifyAble)
          TextButton(
            child:
                Text('Xác nhận', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              _fbKey.currentState.save();
              if (_fbKey.currentState.validate()) {
                otp = _fbKey.currentState.value["otp"];
                updateCredential();
              }
              // Navigator.of(context).pop();
            },
          ),
      ],
    );
  }

  void updateCredential() async {
    SVProgressHUD.show('');
    final _authCredential =
        PhoneAuthProvider.credential(verificationId: actualCode, smsCode: otp);
    await firebaseAuth.currentUser.updatePhoneNumber(_authCredential);
    await accountBloc.mirrorToFirestore(account: this.widget.account);
    await accountBloc.checkUser();
    SVProgressHUD.dismissWithDelay(500);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
