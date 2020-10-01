import 'dart:async';
import 'package:careerplanner/ui/enroll/career_list/career_list_carousel.dart';
import 'package:careerplanner/ui/enroll/career_list/career_list_header.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class EnrollWidget extends StatefulWidget {
  EnrollWidget({Key key}) : super(key: key);

  @override
  _EnrollWidgetState createState() => _EnrollWidgetState();
}

class _EnrollWidgetState extends State<EnrollWidget> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(milliseconds: 400), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidPullToRefresh(
            key: _refreshIndicatorKey, // key if you want to add
            onRefresh: _handleRefresh,
            animSpeedFactor: 8.0,
            child: SafeArea(
              child: ListView(
                children: [
                  CareerListHeader(),
                  SizedBox(height: 16),
                  CareerListCarousel(screenSize: MediaQuery.of(context).size)
                ],
              ),
            )));
  }
}
