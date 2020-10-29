import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/ui/account/student/result_card_widget.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class ExistedStudentAccount extends StatefulWidget {
  ExistedStudentAccount({Key key}) : super(key: key);

  @override
  _ExistedStudentAccountState createState() => _ExistedStudentAccountState();
}

class _ExistedStudentAccountState extends State<ExistedStudentAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CareerPlannerTheme.neutralBackground,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 24,
            title: Text('Cá nhân')),
        body: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Card(
                  semanticContainer: true,
                  color: CareerPlannerTheme.neutralBackground,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 48,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Chào bạn,',
                                style: TextStyle(color: Colors.black54)),
                            SizedBox(height: 4),
                            Text('${accountBloc.accountSubject.value.name}!',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        trailing:
                            CircleAvatar(child: Icon(Icons.account_circle)),
                      ),
                    ),
                  )),
            ),
            ResultCardWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: HomeShortcutWidget(
                  title:
                      'Bạn hiện có ${accountBloc.accountSubject.value.walletBalance} điểm thưởng',
                  icon: Icons.wallet_giftcard_rounded,
                  color: Colors.yellow.shade800,
                  callback: () {
                    Navigator.pushNamed(context, Routes.rewardsRoute);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: HomeShortcutWidget(
                  title: 'Sửa thông tin cá nhân',
                  icon: Icons.edit,
                  color: CareerPlannerTheme.primaryColor,
                  callback: () {
                    Navigator.pushNamed(context, Routes.registerRoute, arguments: 'student');
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: HomeShortcutWidget(
                  title: 'Đăng Xuất',
                  icon: Icons.logout,
                  color: Colors.red.shade600,
                  callback: () {
                    accountBloc.logout();
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(
                        context, Routes.onBoardingRoute);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (BuildContext context,
                      AsyncSnapshot<PackageInfo> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                          'Career Planner v${snapshot.data.version}+${snapshot.data.buildNumber}',
                          style: TextStyle(color: Colors.black54));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            )
          ],
        ));
  }
}
