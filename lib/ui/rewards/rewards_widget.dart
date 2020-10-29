import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class RewardsWidget extends StatefulWidget {
  RewardsWidget({Key key}) : super(key: key);

  @override
  _RewardsWidgetState createState() => _RewardsWidgetState();
}

class _RewardsWidgetState extends State<RewardsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CareerPlannerTheme.primaryColor,
        appBar: AppBar(
            elevation: 24,
            title: Text('Điểm Thưởng'),
            backgroundColor: Colors.black),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Card(
                semanticContainer: true,
                color: CareerPlannerTheme.neutralBackground,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 48,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Điểm thưởng hiện tại của bạn',
                              style: TextStyle(color: Colors.black54)),
                          SizedBox(height: 4),
                          Text(
                              '${accountBloc.accountSubject.value.walletBalance} điểm',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: CareerPlannerTheme.primaryColor)),
                        ],
                      ),
                      trailing: CircleAvatar(
                          child: Icon(Icons.wallet_giftcard_rounded)),
                    ),
                  ),
                )),
          ),
        ]));
  }
}
