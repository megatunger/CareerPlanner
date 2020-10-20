import 'package:careerplanner/model/enroll/university/university_data.dart';
import 'package:careerplanner/model/enroll/university/university_object.dart';
import 'package:careerplanner/ui/enroll/university_list/listing_all_university/university_card.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

class ListingAllUniversity extends StatefulWidget {
  ListingAllUniversity({Key key}) : super(key: key);
  final DatabaseReference universityListRef =
      constants.database.reference().child('university_list');

  @override
  _ListingAllUniversityState createState() => _ListingAllUniversityState();
}

class _ListingAllUniversityState extends State<ListingAllUniversity> {
  UniversityData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatButton.icon(
            icon: Icon(Icons.arrow_back_ios_rounded),
            label: Text('Quay lại'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
            width: double.infinity,
            height: 64,
            child: Padding(
              padding: EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
              child: FlatButton.icon(
                icon: Icon(Icons.search_rounded),
                label: Text('Tìm tên trường'),
                color: Colors.grey.shade200,
                onPressed: () {
                  showSearchScreen();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: this.widget.universityListRef.onValue,
                builder: (context, AsyncSnapshot<Event> snapshot) {
                  if (snapshot.data != null) {
                    data = UniversityData.fromSnapshot(snapshot.data.snapshot);
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
          )
        ],
      ),
    ));
  }

  List<Container> _buildGridTileList(UniversityData data) {
    return List<Container>.generate(
        data.universities.length,
        (int index) => Container(
              child: UniversityCard(universityObject: data.universities[index]),
            ));
  }

  void showSearchScreen() {
    showSearch(
      context: context,
      delegate: SearchPage<UniversityObject>(
        items: data.universities,
        searchLabel: 'Nhập ở đây',
        suggestion: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                  child: Image.asset("assets/illustrations/clip-1063.png")),
              SizedBox(height: 16),
              Text('Bạn muốn tìm hiểu trường nào?',
                  style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        failure: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                  child: Image.asset(
                      "assets/illustrations/hugo-page-not-found.png")),
              SizedBox(height: 8),
              Text('Không tìm thấy thông tin :(',
                  style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        filter: (university) => [
          university.universityName,
        ],
        builder: (universityObject) => Container(
            height: MediaQuery.of(context).size.height * .3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: UniversityCard(universityObject: universityObject),
            )),
      ),
    );
  }
}
