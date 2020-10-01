import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/CareerObject.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerListCarousel extends StatefulWidget {
  CareerListCarousel({Key key, this.screenSize}) : super(key: key);
  final Size screenSize;
  final DatabaseReference careerListRef =
      constants.database.reference().child('career_list');

  @override
  _CareerListCarouselState createState() => _CareerListCarouselState();
}

class _CareerListCarouselState extends State<CareerListCarousel> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: this.widget.careerListRef.limitToFirst(5).onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options:
                  CarouselOptions(height: this.widget.screenSize.height * 0.3),
              items: convertToList(snapshot.data.snapshot).map((careerObject) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: this.widget.screenSize.width * 0.8,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.careerDetailRoute,
                                  arguments: careerObject);
                            },
                            child: Card(
                              semanticContainer: true,
                              color: CareerPlannerTheme.primaryColor,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Hero(
                                    tag: 'career_cover_${careerObject.id}',
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.6),
                                          BlendMode.srcOver),
                                      child: CachedNetworkImage(
                                        imageUrl: careerObject.imagePath,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress,
                                                        backgroundColor:
                                                            Colors.white)),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                        child: Hero(
                                            tag:
                                                'career_title_${careerObject.id}',
                                            child: Text(
                                              '${careerObject.careerName}',
                                              style: GoogleFonts.bungee(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ))),
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            )));
                  },
                );
              }).toList(),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
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
