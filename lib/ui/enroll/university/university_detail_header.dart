import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/university/university_object.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UniversityDetailHeader extends StatefulWidget {
  UniversityDetailHeader({Key key, this.universityObject}) : super(key: key);
  final UniversityObject universityObject;

  @override
  _UniversityDetailHeaderState createState() => _UniversityDetailHeaderState();
}

class _UniversityDetailHeaderState extends State<UniversityDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
                tag: 'university_cover_${this.widget.universityObject.id}',
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.srcOver),
                  child: CachedNetworkImage(
                    imageUrl: this.widget.universityObject.imagePath,
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
                          tag:
                              'university_name_${this.widget.universityObject.id}',
                          child: Text(
                            '${this.widget.universityObject.universityName}',
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
      actions: [],
    );
  }
}
