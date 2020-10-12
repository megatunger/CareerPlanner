import 'package:careerplanner/model/enroll/CareerObject.dart';
import 'package:careerplanner/ui/enroll/career/career_detail_header_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CareerDetailWidget extends StatefulWidget {
  CareerDetailWidget({Key key, this.careerObject}) : super(key: key);
  final CareerObject careerObject;

  @override
  _CareerDetailWidgetState createState() => _CareerDetailWidgetState();
}

class _CareerDetailWidgetState extends State<CareerDetailWidget> {
  GlobalKey favButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _afterLayout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                CareerDetailHeaderWidget(
                  careerObject: this.widget.careerObject,
                  favButtonKey: favButtonKey,
                ),
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '${this.widget.careerObject.description}',
                          style: GoogleFonts.robotoSlab(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 36),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Image.asset(
                          'assets/illustrations/eastwood-school-bag.png'),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showTutorial() {
    TutorialCoachMark tutorial = TutorialCoachMark(context,
        targets: [
          TargetFocus(identify: "Target 2", keyTarget: favButtonKey, contents: [
            ContentTarget(
                align: AlignContent.left,
                child: Container(
                  child: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 64.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ngành nghề này hấp dẫn bạn?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Hãy bấm yêu thích để chúng tôi có thể đưa ra những phân tích về bạn chính xác hơn nhé.",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )),
                ))
          ])
        ], // List<TargetFocus>
        colorShadow: CareerPlannerTheme.secondaryColor, // DEFAULT Colors.black
        // alignSkip: Alignment.bottomRight,
        textSkip: "Bỏ Qua",
        paddingFocus: 30, onFinish: () {
      SharedPreferences.getInstance().then(
          (value) => value.setBool(Constants.showFavButtonGuideKey, true));
    }, onClickTarget: (target) {}, onClickSkip: () {})
      ..show();
  }

  _afterLayout() {
    SharedPreferences.getInstance().then((value) {
      final shown = value.get(Constants.showFavButtonGuideKey);
      if (shown != true) {
        Future.delayed(Duration(milliseconds: 100), () {
          showTutorial();
        });
      }
    });
  }
}
