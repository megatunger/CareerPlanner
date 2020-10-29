import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateThread extends StatefulWidget {
  CreateThread({Key key}) : super(key: key);

  @override
  _CreateThreadState createState() => _CreateThreadState();
}

class _CreateThreadState extends State<CreateThread> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CareerPlannerTheme.neutralBackground,
        appBar: AppBar(
          backgroundColor: CareerPlannerTheme.neutralBackground,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: ListView(children: [
          FormBuilder(
            key: _fbKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: "title",
                    autofocus: true,
                    maxLines: null,
                    style: GoogleFonts.robotoSlabTextTheme()
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        labelText: "Tiêu Đề",
                        hintText: 'Nhập tiêu đề thảo luận'),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  SizedBox(height: 32),
                  FormBuilderTextField(
                    attribute: "body",
                    keyboardType: TextInputType.multiline,
                    style: GoogleFonts.robotoSlabTextTheme()
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        labelText: "Nội dung", hintText: 'Nhập nội dung'),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
