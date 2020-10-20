import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class LoadingImage extends StatelessWidget {
  final String url;
  final String heroTag;
  const LoadingImage({Key key, this.url, this.heroTag = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: TinyColor(CareerPlannerTheme.primaryColor).darken(20).color,
      child: Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
    );
  }
}
