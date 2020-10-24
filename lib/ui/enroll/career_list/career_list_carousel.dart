import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/career/career_data.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerListCarousel extends StatefulWidget {
  CareerListCarousel({Key key, this.screenSize, this.stream}) : super(key: key);
  final Size screenSize;
  final Stream<Event> stream;

  @override
  _CareerListCarouselState createState() => _CareerListCarouselState();
}

class _CareerListCarouselState extends State<CareerListCarousel> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: this.widget.stream,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                height: this.widget.screenSize.height * 0.3,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: CareerData.fromSnapshot(snapshot.data.snapshot)
                  .careers
                  .map((careerObject) {
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
                                  ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.6),
                                        BlendMode.srcOver),
                                    child: CachedNetworkImage(
                                      imageUrl: careerObject.imagePath,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                  backgroundColor:
                                                      Colors.white)),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                        child: Text(
                                      '${careerObject.careerName}',
                                      style: GoogleFonts.bungee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
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
}
