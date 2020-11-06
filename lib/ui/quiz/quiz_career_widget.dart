import 'package:careerplanner/util/ads_helper.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class QuizCareerWidget extends StatefulWidget {
  QuizCareerWidget({Key key}) : super(key: key);

  @override
  _QuizCareerWidgetState createState() => _QuizCareerWidgetState();
}

class _QuizCareerWidgetState extends State<QuizCareerWidget> {
  @override
  void initState() {
    Ads.hideBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 24, title: Text('Trắc Nghiệm Hướng Nghiệp')),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Expanded(
                  child:
                      Image.asset('assets/illustrations/hugo-co-workers.png')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Trắc Nghiệm Hướng Nghiệp Holland',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, bottom: 16, top: 4),
                child: Text(
                    'Trắc nghiệm Holland được phát triển bởi tiến sĩ tâm lý học người Mỹ – John Holland và đã được sử dụng khá rộng rãi trong hướng nghiệp phổ thông tại các quốc gia phát triển nhất về giáo dục như Hà Lan, New Zealand, Thuỵ Sỹ, Italy…',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, bottom: 32, top: 32),
                child: Container(
                    width: double.infinity,
                    height: 56,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.quizQuestionsRoute);
                      },
                      elevation: 32,
                      color: CareerPlannerTheme.thirdColor,
                      child: Text('BẮT ĐẦU LÀM',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    )),
              )
            ])));
  }

  @override
  void dispose() {
    Ads.showBannerAd();
    super.dispose();
  }
}
