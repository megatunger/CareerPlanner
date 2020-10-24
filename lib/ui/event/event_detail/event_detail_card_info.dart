import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/util/app_util.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

import 'event_info_card.dart';

class EventDetailCardInfo extends StatelessWidget {
  final Size size;
  final EventObject event;
  const EventDetailCardInfo({Key key, this.size, this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.8,
      width: size.width - 16,
      child: Card(
        semanticContainer: true,
        color: CareerPlannerTheme.primaryColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: 'event_cover_${event.id}',
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.srcOver),
                child: CachedNetworkImage(
                  imageUrl: event.imagePath,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              backgroundColor: Colors.white)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: ClipRect(
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.8)),
                      child: Container(
                          height: size.height * .35,
                          width: size.width - 16,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      EventInfoCard(
                                          icon: Icons.account_circle,
                                          iconColor: Colors.blue,
                                          title: 'Tổ chức bởi',
                                          subtitle: '${event.eventBy}'),
                                      EventInfoCard(
                                          icon: Icons.location_pin,
                                          iconColor: Colors.yellow,
                                          title: 'Địa điểm',
                                          subtitle: '${event.location}'),
                                      EventInfoCard(
                                          icon: Icons.calendar_today,
                                          iconColor: Colors.green,
                                          title: 'Diễn ra lúc',
                                          subtitle:
                                              '${AppUtil().toDateString(event.start)}'),
                                      EventInfoCard(
                                          icon: Icons.calendar_today,
                                          iconColor: Colors.red,
                                          title: 'Kết thúc vào',
                                          subtitle:
                                              '${AppUtil().toDateString(event.end)}')
                                    ])
                              ],
                            ),
                          )),
                    ),
                  ),
                )),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 32,
      ),
    );
  }
}
