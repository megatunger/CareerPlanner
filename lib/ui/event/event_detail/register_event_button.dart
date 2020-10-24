import 'package:careerplanner/bloc/event/event_bloc.dart';
import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class RegisterEventButton extends StatefulWidget {
  RegisterEventButton({Key key, this.event}) : super(key: key);
  final EventObject event;
  @override
  _RegisterEventButtonState createState() => _RegisterEventButtonState();
}

class _RegisterEventButtonState extends State<RegisterEventButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, top: 32),
      child: Container(
          width: double.infinity,
          height: 56,
          child: RaisedButton(
            onPressed: () {
              eventBloc.registerEvent(this.widget.event);
            },
            elevation: 32,
            color: CareerPlannerTheme.primaryColor,
            child: Text('Đăng kí tham gia',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
          )),
    );
  }
}
