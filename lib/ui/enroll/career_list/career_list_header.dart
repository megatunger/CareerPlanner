import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 4, top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NHÓM NGÀNH',
                  style: GoogleFonts.lexendDeca(
                      textStyle: Theme.of(context).textTheme.headline6,
                      fontWeight: FontWeight.w700,
                      color: CareerPlannerTheme.thirdColor),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4),
                Text(
                  'Thông tin hữu ích về ngành nghề',
                  style: GoogleFonts.lexendDeca(
                    textStyle: Theme.of(context).textTheme.caption,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ]),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.careerAllRoute);
            },
            child: Row(
              children: [
                Text('Tìm Hiểu Thêm'),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                )
              ],
            ),
            textColor: CareerPlannerTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}