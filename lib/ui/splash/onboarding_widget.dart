import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingWidget extends StatefulWidget {
  OnboardingWidget({Key key}) : super(key: key);

  @override
  _OnboardingWidgetState createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Align(
        child: Image.asset('assets/illustrations/$assetName'),
        alignment: Alignment.center,
      ),
    ));
  }

  @override
  void initState() {
    FirebaseAuth.instance.signOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Chào mừng bạn đến với\nCareer Planner!",
          body:
              "Chúng tôi sẽ hỗ trợ bạn tìm định hướng nghề nghiệp cho bản thân",
          image: _buildImage('bermuda-704.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tư vấn định hướng thông minh",
          body:
              "Ứng dụng sẽ phân tích các tương tác của bạn với nội dung trên ứng dụng, kết hợp với bài trắc nghiệp để đưa ra những lời khuyên thích hợp cho bạn",
          image: _buildImage('bermuda-page-not-found.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tìm hiểu thông tin\nngành nghề",
          body:
              "Chúng tôi có bộ thông tin đầy đủ & phong phú giúp bạn có cái nhìn tổng quan về nghề nghiệp",
          image: _buildImage('bermuda-759.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tìm hiểu thông tin về\ncác cơ sở đào tạo",
          body:
              "Chúng tôi sẽ giúp bạn nắm được thông tin tuyển sinh của các trường đơn giản & dễ dàng",
          image: _buildImage('bermuda-school.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tham dự các Workshop",
          body:
              "Ứng dụng đem đến cho các bạn những sự kiện, workshop về ngành nghề giúp bạn có những trải nghiệm thực tế hữu ích",
          image: _buildImage('bermuda-699.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Và nhiều chức năng khác đang chờ bạn khám phá!",
          bodyWidget: Column(
            children: [
              SizedBox(height: 16),
              Container(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    elevation: 24,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      saveShownOnboarding();
                    },
                    textColor: Colors.white,
                    child: Text(
                      'Bắt Đầu Sử Dụng',
                      style: TextStyle(fontSize: 16),
                    ),
                    color: CareerPlannerTheme.primaryColor,
                  )),
            ],
          ),
          image: _buildImage('sign-in-4.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => saveShownOnboarding(),
      onSkip: () => saveShownOnboarding(), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Bỏ Qua'),
      next: const Icon(Icons.arrow_forward),
      done: Text(''),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: CareerPlannerTheme.secondaryColor.withOpacity(0.2),
        activeSize: Size(22.0, 10.0),
        activeColor: CareerPlannerTheme.secondaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void saveShownOnboarding() async {
    print('End of onboarding');
    SVProgressHUD.show(status: '');
    FirebaseAuth.instance.signInAnonymously().then((value) async {
      await SharedPreferences.getInstance().then((value) {
        value.setBool(Constants.shownOnboardingScreen, true);
        accountBloc.createNewCollection();
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
        SVProgressHUD.dismiss(delay: Duration(milliseconds: 1500));
      });
    });
  }
}
