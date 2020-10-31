import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class WelcomeNewAccount extends StatefulWidget {
  WelcomeNewAccount({Key key}) : super(key: key);

  @override
  _WelcomeNewAccountState createState() => _WelcomeNewAccountState();
}

class _WelcomeNewAccountState extends State<WelcomeNewAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.08), BlendMode.dstIn),
            image: AssetImage("assets/illustrations/4086124.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Column(children: [
          Expanded(
              child: Image.asset('assets/illustrations/flame-training.png')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16),
            child: Text(
              'Cảm ơn bạn đã cài đặt Career Planner, bạn là?',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black54, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24),
            child: HomeShortcutWidget(
                title: 'Học Sinh',
                icon: Icons.account_box_rounded,
                color: CareerPlannerTheme.primaryColor,
                callback: () {
                  Navigator.pushNamed(context, Routes.registerRoute,
                      arguments: 'student');
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24),
            child: HomeShortcutWidget(
                title: 'Chuyên gia / Tư vấn viên',
                icon: Icons.people,
                color: TinyColor(CareerPlannerTheme.secondaryColor)
                    .darken(20)
                    .color,
                callback: () {
                  Navigator.pushNamed(context, Routes.registerRoute,
                      arguments: 'mentor');
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24),
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginByPhoneRoute);
                    },
                    child: Text('Đã có tài khoản?')),
              ),
            ),
          ),
          SizedBox(height: 64)
        ])));
  }
}
