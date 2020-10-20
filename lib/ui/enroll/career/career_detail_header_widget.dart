import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:careerplanner/ui/enroll/career/favourite_button.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerDetailHeaderWidget extends StatefulWidget {
  CareerDetailHeaderWidget({Key key, this.careerObject, this.favButtonKey})
      : super(key: key);
  final CareerObject careerObject;
  final GlobalKey favButtonKey;

  @override
  _CareerDetailHeaderWidgetState createState() =>
      _CareerDetailHeaderWidgetState();
}

class _CareerDetailHeaderWidgetState extends State<CareerDetailHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      stretch: true,
      backgroundColor: CareerPlannerTheme.primaryColor,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground, StretchMode.blurBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'career_cover_${this.widget.careerObject.id}',
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.srcOver),
                  child: CachedNetworkImage(
                    imageUrl: this.widget.careerObject.imagePath,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                backgroundColor: Colors.white)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                          tag: 'career_title_${this.widget.careerObject.id}',
                          child: Text(
                            '${this.widget.careerObject.careerName}',
                            style: GoogleFonts.bungee(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
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
        FavouriteButton(
            careerObject: this.widget.careerObject,
            favButtonKey: this.widget.favButtonKey)
      ],
    );
  }
}
