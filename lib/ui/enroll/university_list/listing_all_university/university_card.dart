import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/university/university_object.dart';
import 'package:careerplanner/util/router.dart';
import 'package:flutter/material.dart';

class UniversityCard extends StatefulWidget {
  UniversityCard({Key key, this.universityObject}) : super(key: key);
  final UniversityObject universityObject;
  @override
  _UniversityCardState createState() => _UniversityCardState();
}

class _UniversityCardState extends State<UniversityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.universityDetailRoute,
            arguments: this.widget.universityObject);
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'university_cover_${this.widget.universityObject.id}',
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      this.widget.universityObject.imagePath,
                    ),
                  ),
                ),
                elevation: 16.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              '${this.widget.universityObject.universityName}',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
