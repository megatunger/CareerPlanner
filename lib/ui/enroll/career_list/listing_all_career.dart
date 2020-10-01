import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/CareerObject.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListingAllCareer extends StatefulWidget {
  ListingAllCareer({Key key}) : super(key: key);
  final DatabaseReference careerListRef =
      constants.database.reference().child('career_list');

  @override
  _ListingAllCareerState createState() => _ListingAllCareerState();
}

class _ListingAllCareerState extends State<ListingAllCareer> {
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
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        label: Text('Tìm tên ngành'))
                  ],
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
                StreamBuilder(
                    stream: this.widget.careerListRef.onValue,
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        final data = convertToList(snapshot.data.snapshot);
                        return SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          final _careerObject = data[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.careerDetailRoute,
                                  arguments: _careerObject);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16, top: 4, bottom: 4),
                              child: Container(
                                  height: 120,
                                  child: Card(
                                    semanticContainer: true,
                                    color: CareerPlannerTheme.primaryColor,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Hero(
                                          tag:
                                              'career_cover_${_careerObject.id}',
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.6),
                                                BlendMode.srcOver),
                                            child: CachedNetworkImage(
                                              imageUrl: _careerObject.imagePath,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress,
                                                              backgroundColor:
                                                                  Colors
                                                                      .white)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(16, 0, 8, 16),
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Hero(
                                                  tag:
                                                      'career_title_${_careerObject.id}',
                                                  child: Text(
                                                    '${_careerObject.careerName}',
                                                    style:
                                                        GoogleFonts.lexendDeca(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.white),
                                                    textAlign: TextAlign.left,
                                                  ))),
                                        )
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 0,
                                  )),
                            ),
                          );
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

  List<CareerObject> convertToList(DataSnapshot data) {
    List<CareerObject> careerList = [];
    careerList.clear();
    List<dynamic> values = data.value;
    values.forEach((element) {
      if (element != null) {
        var map = HashMap.from(element);
        careerList.add(CareerObject(
            id: map['id'],
            imagePath: map['image_path'],
            careerName: map['career_name']));
      }
    });
    return careerList;
  }
}
