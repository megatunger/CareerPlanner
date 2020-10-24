import 'package:careerplanner/model/enroll/university/university_data.dart';
import 'package:careerplanner/ui/enroll/university_list/listing_all_university/university_card.dart';
import 'package:careerplanner/ui/shared/empty_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UniversityBubblesWidget extends StatefulWidget {
  UniversityBubblesWidget({Key key, this.stream}) : super(key: key);
  final Stream<Event> stream;
  @override
  _UniversityBubblesWidgetState createState() =>
      _UniversityBubblesWidgetState();
}

class _UniversityBubblesWidgetState extends State<UniversityBubblesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: this.widget.stream,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.data != null) {
              final data = UniversityData.fromSnapshot(snapshot.data.snapshot);
              if (data.universities.isEmpty) {
                return EmptyState();
              }
              return GridView.extent(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  maxCrossAxisExtent: MediaQuery.of(context).size.width *
                      0.5, // maximum pixel width of a item
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: _buildGridTileList(data));
            } else {
              return LinearProgressIndicator();
            }
          }),
    );
  }

  List<Container> _buildGridTileList(UniversityData data) {
    return List<Container>.generate(
        data.universities.length,
        (int index) => Container(
              child: UniversityCard(universityObject: data.universities[index]),
            ));
  }
}
