import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/account/account_object.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterFormWidget extends StatefulWidget {
  RegisterFormWidget({Key key, this.accountType}) : super(key: key);
  final String accountType;
  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final spaceRow = 16.0;
  @override
  void initState() {
    accountBloc.getCurrentInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: CareerPlannerTheme.neutralBackground,
        appBar: AppBar(
          elevation: 24,
        ),
        body: Container(
          child: StreamBuilder<AccountObject>(
            stream: accountBloc.accountSubject.stream,
            builder: (context, AsyncSnapshot<AccountObject> snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> initialState =
                    accountBloc.accountSubject.value.toJson();
                initialState.addAll({
                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                  'account_type': this.widget.accountType,
                  'uid': accountBloc.currentUser().uid,
                });
                return ListView(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.asset(
                                'assets/illustrations/kingdom-4.png')),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Bạn hãy bổ sung những thông tin sau nhé!',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(),
                        FormBuilder(
                          key: _fbKey,
                          initialValue: initialState,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                FormBuilderTextField(
                                  attribute: "name",
                                  textCapitalization: TextCapitalization.words,
                                  decoration:
                                      InputDecoration(labelText: "Họ và tên"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                  ],
                                ),
                                SizedBox(height: spaceRow),
                                FormBuilderTextField(
                                  attribute: "age",
                                  decoration:
                                      InputDecoration(labelText: "Tuổi"),
                                  validators: [
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.max(70),
                                  ],
                                ),
                                SizedBox(height: spaceRow),
                                FormBuilderDropdown(
                                  attribute: "gender",
                                  decoration:
                                      InputDecoration(labelText: "Giới Tính"),
                                  // initialValue: 'Male',
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                  items: ['Nam', 'Nữ']
                                      .map((gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text("$gender")))
                                      .toList(),
                                ),
                                SizedBox(height: spaceRow),
                                FormBuilderTextField(
                                  attribute: "email",
                                  decoration: InputDecoration(
                                      labelText: "Địa chỉ Email"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.email(),
                                  ],
                                ),
                                SizedBox(height: spaceRow),
                                FormBuilderPhoneField(
                                  attribute: "phone",
                                  defaultSelectedCountryIsoCode: 'VN',
                                  decoration: InputDecoration(
                                      labelText: "Số điện thoại"),
                                ),
                                SizedBox(height: spaceRow),
                                FormBuilderTextField(
                                  attribute: "school",
                                  decoration: InputDecoration(
                                      labelText:
                                          (this.widget.accountType == 'student')
                                              ? "Trường bạn đang theo học?"
                                              : 'Nơi công tác'),
                                ),
                                SizedBox(height: spaceRow),
                                FormBuilderTextField(
                                  attribute: "ref_user",
                                  decoration: InputDecoration(
                                      labelText: "Mã giới thiệu"),
                                ),
                                SizedBox(height: spaceRow),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 32, top: 32),
                          child: Container(
                              width: double.infinity,
                              height: 56,
                              child: RaisedButton(
                                onPressed: save,
                                elevation: 32,
                                color: CareerPlannerTheme.thirdColor,
                                child: Text('Lưu',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(color: Colors.white)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                              )),
                        ),
                        SizedBox(height: 32)
                      ],
                    )
                  ],
                );
              }
              return LoadingWidget();
            },
          ),
        ));
  }

  void save() {
    _fbKey.currentState.save();
    if (_fbKey.currentState.validate()) {
      final account = AccountObject.fromJson(_fbKey.currentState.value);
      accountBloc
          .updateInformation(account: account, scaffoldKey: _scaffoldKey)
          .then((value) {});
    } else {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Vui lòng kiểm tra lại các thông tin!')));
    }
  }
}
