import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/CareerObject.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerDetailWidget extends StatefulWidget {
  CareerDetailWidget({Key key, this.careerObject}) : super(key: key);
  final CareerObject careerObject;

  @override
  _CareerDetailWidgetState createState() => _CareerDetailWidgetState();
}

class _CareerDetailWidgetState extends State<CareerDetailWidget> {
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
                  backgroundColor: CareerPlannerTheme.primaryColor,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.zoomBackground,
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: Hero(
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
                        textColor: Colors.white,
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline_rounded),
                        label: Text('Yêu Thích'))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
