import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/account/mentor_object.dart';
import 'package:careerplanner/ui/connect/mentor/connect_mentor_widget.dart';
import 'package:flutter/material.dart';

class MentorBubble extends StatefulWidget {
  MentorBubble({Key key, this.mentor}) : super(key: key);
  final MentorObject mentor;
  @override
  _MentorBubbleState createState() => _MentorBubbleState();
}

class _MentorBubbleState extends State<MentorBubble> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: AppBar(
                      elevation: 24,
                      title: Text('${this.widget.mentor.mentorName}')
                    ),
                    body: ConnectMentorWidget(
                      mentorUid: this.widget.mentor.uid,
                    ))));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    this.widget.mentor.mentorImage,
                  ),
                ),
                elevation: 16.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  '${this.widget.mentor.mentorName}',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  '${this.widget.mentor.mentorSchool}',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
