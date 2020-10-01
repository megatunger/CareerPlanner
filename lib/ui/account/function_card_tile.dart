import 'package:flutter/material.dart';

class FunctionCardTile extends StatelessWidget {
  FunctionCardTile({Key key, this.title, this.iconTrailing, this.onTap})
      : super(key: key);
  final VoidCallback onTap;
  final String title;
  final IconData iconTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade200,
        child: Icon(iconTrailing, color: Colors.grey),
      ),
      trailing:
          Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400),
      onTap: onTap,
      title: Text('$title',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
    );
  }
}
