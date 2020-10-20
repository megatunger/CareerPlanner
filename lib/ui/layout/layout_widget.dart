import 'package:careerplanner/bloc/layout/bottom_nav_bar_bloc.dart';
import 'package:careerplanner/ui/account/authentication_redirect.dart';
import 'package:careerplanner/ui/enroll/enroll_widget.dart';
import 'package:careerplanner/ui/home/home_widget.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LayoutWidget extends StatefulWidget {
  LayoutWidget({Key key}) : super(key: key);

  @override
  _LayoutWidgetState createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.HOME:
              return HomeWidget();
            case NavBarItem.ENROLL:
              return EnrollWidget();
            case NavBarItem.ACCOUNT:
              return AuthenticationRedirect();
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: 250),
                    tabBackgroundColor: CareerPlannerTheme.primaryColor,
                    tabs: [
                      GButton(
                        icon: Icons.auto_stories,
                        iconColor: CareerPlannerTheme.primaryColor,
                        text: 'Hướng Nghiệp',
                      ),
                      GButton(
                        icon: Icons.school,
                        iconColor: CareerPlannerTheme.primaryColor,
                        text: 'Tuyển Sinh',
                      ),
                      GButton(
                        icon: Icons.account_circle,
                        iconColor: CareerPlannerTheme.primaryColor,
                        text: 'Tài Khoản',
                      ),
                    ],
                    selectedIndex: snapshot.data.index,
                    onTabChange: _bottomNavBarBloc.pickItem),
              ),
            ),
          );
        },
      ),
    );
  }
}
