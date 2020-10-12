import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/enroll/CareerObject.dart';
import 'package:careerplanner/ui/account/authentication_redirect.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool favourite = false;
  GlobalKey favButton = GlobalKey();

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
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  stretch: true,
                  backgroundColor: CareerPlannerTheme.primaryColor,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.zoomBackground,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag: 'career_cover_${this.widget.careerObject.id}',
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.srcOver),
                              child: CachedNetworkImage(
                                imageUrl: this.widget.careerObject.imagePath,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            backgroundColor: Colors.white)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Hero(
                                      transitionOnUserGestures: true,
                                      tag:
                                          'career_title_${this.widget.careerObject.id}',
                                      child: Text(
                                        '${this.widget.careerObject.careerName}',
                                        style: GoogleFonts.bungee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            color: Colors.white),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    FlatButton.icon(
                        key: favButton,
                        textColor: Colors.white,
                        onPressed: () async {
                          tapFavourite();
                        },
                        icon: StreamBuilder(
                            stream: accountBloc.didFavouriteCareer(
                                this.widget.careerObject.careerCode),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.docs.length > 0 &&
                                    snapshot.data.docs.last
                                            .data()["favourite"] ==
                                        true) {
                                  print("Favourite this career!");
                                  favourite = true;
                                } else {
                                  print("Not favourite this career!");
                                  favourite = false;
                                }
                              }
                              return (favourite == true)
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_outline_rounded);
                            }),
                        label: Text('Yêu Thích'))
                  ],
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
          TargetFocus(identify: "Target 2", keyTarget: favButton, contents: [
            ContentTarget(
                align: AlignContent.left,
                child: Container(
                  child: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
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
      print('${Constants.showFavButtonGuideKey}: $shown');
      if (shown != true) {
        Future.delayed(Duration(milliseconds: 100), () {
          showTutorial();
        });
      }
    });
  }

  void tapFavourite() async {
    await accountBloc.updateFavouriteCareer(
        this.widget.careerObject.careerCode, !favourite);
  }
}
