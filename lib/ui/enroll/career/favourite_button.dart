import 'package:careerplanner/bloc/enroll/career/career_bloc.dart';
import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavouriteButton extends StatefulWidget {
  FavouriteButton({Key key, this.careerObject, this.favButtonKey})
      : super(key: key);
  final CareerObject careerObject;
  final GlobalKey favButtonKey;

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        key: this.widget.favButtonKey,
        textColor: Colors.white,
        onPressed: () async {
          tapFavourite();
        },
        icon: StreamBuilder(
            stream: careerBloc.didFavouriteCareer(this.widget.careerObject),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0 &&
                    snapshot.data.docs.last.data()["favourite"] == true) {
                  print("Favourite this career!");
                  favourite = true;
                } else {
                  print("Not favourite this career!");
                  favourite = false;
                }
              }
              return (favourite == true)
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline_rounded);
            }),
        label: Text('Yêu Thích'));
  }

  void tapFavourite() async {
    careerBloc.updateFavouriteCareer(this.widget.careerObject, !favourite);
  }
}
