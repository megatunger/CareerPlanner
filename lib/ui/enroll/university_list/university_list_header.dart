import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class UniversityListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DANH SÁCH CƠ SỞ ĐÀO TẠO',
            style: Theme.of(context).textTheme.headline6.copyWith(
                color: CareerPlannerTheme.thirdColor,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 4),
          Text(
            'Tổng hợp thông tin hữu ích về trường, ngành đào tạo, điểm đầu vào các năm...',
            // overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
          )
        ],
      ),
    );
  }
}
