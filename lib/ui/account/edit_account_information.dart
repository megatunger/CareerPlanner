import 'package:flutter/material.dart';

class EditAccountInformation extends StatefulWidget {
  EditAccountInformation({Key key}) : super(key: key);

  @override
  _EditAccountInformationState createState() => _EditAccountInformationState();
}

class _EditAccountInformationState extends State<EditAccountInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa Thông Tin Cá Nhân'),
      ),
    );
  }
}
