import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventObject event;
  final Size size;

  const EventCard({Key key, this.event, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.eventsDetailRoute,
              arguments: event);
        },
        child: Container(
          height: size.height * 0.3,
          width: size.width - 16,
          child: Card(
            semanticContainer: true,
            color: CareerPlannerTheme.primaryColor,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.srcOver),
                  child: CachedNetworkImage(
                    imageUrl: event.imagePath,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                backgroundColor: Colors.white)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 32, 16),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '${event.eventName}',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0,
          ),
        ));
  }
}
