import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class CareerCard extends StatelessWidget {
  final CareerObject _careerObject;
  CareerCard(this._careerObject);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.careerDetailRoute,
            arguments: _careerObject);
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, top: 4, bottom: 4),
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
                    transitionOnUserGestures: true,
                    tag: 'career_cover_${_careerObject.id}',
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.srcOver),
                      child: CachedNetworkImage(
                        imageUrl: _careerObject.imagePath,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 8, 16),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'career_title_${_careerObject.id}',
                                child: Text(
                                  '${_careerObject.careerName}',
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                  textAlign: TextAlign.left,
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white.withAlpha(100),
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 0,
            )),
      ),
    );
  }
}
