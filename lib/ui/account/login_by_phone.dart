import 'package:careerplanner/ui/account/phone_verify/phone_login_widget.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinycolor/tinycolor.dart';

class LoginByPhone extends StatefulWidget {
  LoginByPhone({Key key}) : super(key: key);

  @override
  _LoginByPhoneState createState() => _LoginByPhoneState();
}

class _LoginByPhoneState extends State<LoginByPhone> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CareerPlannerTheme.neutralBackground,
        appBar: AppBar(
          backgroundColor: CareerPlannerTheme.neutralBackground,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: ListView(children: [
          FormBuilder(
            key: _fbKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FormBuilderPhoneField(
                    attribute: "phone",
                    autofocus: true,
                    defaultSelectedCountryIsoCode: 'VN',
                    style: GoogleFonts.robotoSlabTextTheme()
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                    decoration: InputDecoration(
                      labelText: "Nhập số điện thoại",
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: HomeShortcutWidget(
                      title: 'Gửi mã OTP',
                      icon: Icons.people,
                      color: TinyColor(CareerPlannerTheme.secondaryColor)
                          .darken(20)
                          .color,
                      callback: () {
                        if (_fbKey.currentState.validate()) {
                          _fbKey.currentState.save();
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return PhoneLoginWidget(
                                  phoneNumber:
                                      _fbKey.currentState.value["phone"]);
                            },
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ]));
  }
}
