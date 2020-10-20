import 'package:cached_network_image/cached_network_image.dart';
import 'package:careerplanner/model/enroll/university/university_object.dart';
import 'package:careerplanner/ui/shared/web_view_container.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class UniversityDetail extends StatefulWidget {
  UniversityDetail({Key key, this.universityObject}) : super(key: key);
  final UniversityObject universityObject;

  @override
  _UniversityDetailState createState() => _UniversityDetailState();
}

class _UniversityDetailState extends State<UniversityDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('${this.widget.universityObject.universityName}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'university_cover_${this.widget.universityObject.id}',
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  this.widget.universityObject.imagePath,
                ),
              ),
            ),
          )
        ],
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          isScrollable: true,
          labelColor: CareerPlannerTheme.secondaryColor,
          tabs: [
            new Tab(text: 'GIỚI THIỆU'),
            new Tab(text: 'NGÀNH ĐÀO TẠO'),
            new Tab(text: 'TUYỂN SINH'),
            new Tab(text: 'ĐIỂM NĂM GẦN ĐÂY'),
            new Tab(text: 'LIÊN HỆ'),
          ],
          controller: _tabController,
          indicatorColor: CareerPlannerTheme.secondaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          tabBarContent(this.widget.universityObject.gioiThieuLink),
          tabBarContent(this.widget.universityObject.nganhDaoTaoLink),
          tabBarContent(this.widget.universityObject.tuyenSinhLink),
          tabBarContent(this.widget.universityObject.diemNamGanDayLink),
          tabBarContent(this.widget.universityObject.lienHeLink),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget tabBarContent(String url) {
    if (url != '') {
      return WebViewContainer(
        url: url,
        allowFollowLink: false,
      );
    } else {
      return Column(
        children: [],
      );
    }
  }
}
