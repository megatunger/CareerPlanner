import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset("assets/illustrations/hugo-page-not-found.png"),
          Text('Thông tin sẽ được cập nhật sau :(',
              style: Theme.of(context).textTheme.subtitle1),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
