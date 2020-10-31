import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ThreadImagesCarousel extends StatefulWidget {
  ThreadImagesCarousel({Key key, this.images, this.screenSize})
      : super(key: key);
  final List<ImagesObject> images;
  final Size screenSize;
  @override
  _ThreadImagesCarouselState createState() => _ThreadImagesCarouselState();
}

class _ThreadImagesCarouselState extends State<ThreadImagesCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: this.widget.screenSize.height * 0.4,
        aspectRatio: 3 / 2,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: this.widget.images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: this.widget.screenSize.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Card(
                  semanticContainer: true,
                  color: CareerPlannerTheme.primaryColor,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: FutureBuilder(
                    future: FirebaseStorage()
                        .ref()
                        .child(image.path)
                        .getDownloadURL(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return CachedNetworkImage(
                          imageUrl: snapshot.data,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      backgroundColor: Colors.white)),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 0,
                ));
          },
        );
      }).toList(),
    );
  }
}
