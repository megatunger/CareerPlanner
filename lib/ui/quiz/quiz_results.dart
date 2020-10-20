import 'package:flutter/material.dart';

class QuizResults extends StatefulWidget {
  QuizResults({Key key}) : super(key: key);

  @override
  _QuizResultsState createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Kết Quả Phân Tích')), body: Container());
  }
}
