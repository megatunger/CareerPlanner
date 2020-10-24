import 'package:flutter/material.dart';

class EventInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const EventInfoCard(
      {Key key, this.icon, this.iconColor, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: iconColor, size: 32),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 14)),
            Text(
              '$subtitle',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )
    ]);
  }
}
