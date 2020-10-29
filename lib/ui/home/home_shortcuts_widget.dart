import 'package:flutter/material.dart';

class HomeShortcutWidget extends StatelessWidget {
  const HomeShortcutWidget(
      {Key key, this.title, this.icon, this.color, this.callback})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback callback;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16.0),
            child: functionCard(),
          ),
        ));
  }

  Widget functionCard() {
    return Card(
        elevation: 0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(icon, color: Colors.white),
            Text(
              '$title',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
          ]),
        ));
  }
}
