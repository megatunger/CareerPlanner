import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:careerplanner/ui/enroll/career/career_detail_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerDetailWidget extends StatefulWidget {
  CareerDetailWidget({Key key, this.careerObject}) : super(key: key);
  final CareerObject careerObject;

  @override
  _CareerDetailWidgetState createState() => _CareerDetailWidgetState();
}

class _CareerDetailWidgetState extends State<CareerDetailWidget> {
  GlobalKey favButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                CareerDetailHeaderWidget(
                  careerObject: this.widget.careerObject,
                  favButtonKey: favButtonKey,
                ),
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '${this.widget.careerObject.description}',
                          style: GoogleFonts.robotoSlab(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 36),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Image.asset(
                          'assets/illustrations/eastwood-school-bag.png'),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
