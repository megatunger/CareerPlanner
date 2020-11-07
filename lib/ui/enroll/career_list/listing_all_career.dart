import 'package:careerplanner/model/enroll/career/career_data.dart';
import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:careerplanner/ui/enroll/career_list/listing_all_career/career_card.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/util/ads_helper.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_page/search_page.dart';

class ListingAllCareer extends StatefulWidget {
  ListingAllCareer({Key key}) : super(key: key);
  final DatabaseReference careerListRef =
      constants.database.reference().child('career_list');

  @override
  _ListingAllCareerState createState() => _ListingAllCareerState();
}

class _ListingAllCareerState extends State<ListingAllCareer> {
  List<CareerObject> data = [];
  @override
  void initState() {
    super.initState();
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
                  pinned: true,
                  backgroundColor: CareerPlannerTheme.primaryColor,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.zoomBackground,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                            child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6), BlendMode.srcOver),
                          child: Image.asset(
                            'assets/illustrations/friendship.png',
                            fit: BoxFit.cover,
                          ),
                        )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Thông Tin\nNgành Nghề',
                                    style: GoogleFonts.bungee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
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
                        textColor: Colors.white,
                        onPressed: () {
                          showSearchScreen();
                        },
                        icon: Icon(Icons.search),
                        label: Text('Tìm tên ngành',
                            style: TextStyle(fontSize: 16)))
                  ],
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
                StreamBuilder(
                    stream: this.widget.careerListRef.onValue,
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        data = CareerData.fromSnapshot(snapshot.data.snapshot)
                            .careers;
                        return SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          final _careerObject = data[index];
                          return CareerCard(_careerObject);
                        }, childCount: data.length));
                      } else {
                        return SliverFillRemaining(child: LoadingWidget());
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showSearchScreen() {
    showSearch(
      context: context,
      delegate: SearchPage<CareerObject>(
        items: data,
        searchLabel: 'Nhập ở đây',
        suggestion: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                  child: Image.asset("assets/illustrations/clip-1063.png")),
              SizedBox(height: 16),
              Text('Bạn muốn tìm hiểu về ngành gì?',
                  style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        failure: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                  child: Image.asset(
                      "assets/illustrations/hugo-page-not-found.png")),
              SizedBox(height: 8),
              Text('Không tìm thấy ngành này :(',
                  style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        filter: (career) => [
          career.careerName,
          career.description,
          career.careerCode,
        ],
        builder: (career) => CareerCard(career),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
