import 'package:careerplanner/bloc/event/event_bloc.dart';
import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class RegisterEventButton extends StatefulWidget {
  RegisterEventButton({Key key, this.event, this.scaffoldKey})
      : super(key: key);
  final EventObject event;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _RegisterEventButtonState createState() => _RegisterEventButtonState();
}

class _RegisterEventButtonState extends State<RegisterEventButton> {
  bool registered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, top: 32),
      child: Container(
          width: double.infinity,
          height: 56,
          child: RaisedButton(
            onPressed: () {
              if (registered) {
                this.widget.scaffoldKey.currentState.showSnackBar(
                    new SnackBar(content: new Text('Đã huỷ đăng ký!')));
                eventBloc.registerEvent(
                    event: this.widget.event, register: false);
                setState(() {
                  registered = false;
                });
              } else {
                this.widget.scaffoldKey.currentState.showSnackBar(new SnackBar(
                    content: new Text('Đăng ký tham gia thành công!')));
                eventBloc.registerEvent(
                    event: this.widget.event, register: true);
                setState(() {
                  registered = true;
                });
              }
            },
            elevation: 32,
            color: registered
                ? Colors.red.shade700
                : CareerPlannerTheme.primaryColor,
            child: Text(registered ? "Huỷ đăng kí" : 'Đăng kí tham gia',
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
