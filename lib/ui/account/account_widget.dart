import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/ui/account/edit_account_information/edit_account_form.dart';
import 'package:careerplanner/ui/account/function_card_tile.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/util/router.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  AccountWidget({Key key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: accountBloc.isNewUser(accountBloc.currentUser()),
      builder: (_, snap) {
        Widget _widget;
        print(snap);
        if (snap.hasData) {
          if (snap.data == true) {
            _widget = EditAccountForm();
          } else {
            _widget = existedAccount();
          }
        } else {
          _widget = LoadingWidget();
        }
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 750),
            switchInCurve: Curves.easeInOutQuart,
            switchOutCurve: Curves.easeInOutQuart,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: _widget);
      },
    );
  }

  Widget newAccount() {
    return Text("tai khoan moi");
  }

  Widget existedAccount() {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Divider(),
                        FunctionCardTile(
                          title: 'Sửa Thông Tin Cá Nhân',
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.editAccountRoute);
                          },
                          iconTrailing: Icons.edit,
                        ),
                        FunctionCardTile(
                          title: 'Về Ứng Dụng',
                          onTap: () {
                            Navigator.pushNamed(context, Routes.aboutUsRoute);
                          },
                          iconTrailing: Icons.mobile_friendly,
                        ),
                        Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.red.shade50,
                            child: Icon(Icons.assignment_return,
                                color: Colors.red.shade500),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.grey.shade400),
                          onTap: () {
                            accountBloc.logout();
                          },
                          title: Text('Đăng Xuất',
                              style: TextStyle(
                                  color: Colors.red.shade500,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )))));
  }
}
