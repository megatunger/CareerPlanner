import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/bloc/thread/thread_bloc.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:careerplanner/util/ads_helper.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CreateThread extends StatefulWidget {
  CreateThread({Key key, this.createdThread, this.mentorUid}) : super(key: key);
  final ThreadObject createdThread;
  final String mentorUid;
  @override
  _CreateThreadState createState() => _CreateThreadState();
}

class _CreateThreadState extends State<CreateThread> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool saved = false;
  ThreadObject thread =
      ThreadObject(id: Uuid().v4(), uid: accountBloc.currentUser().uid);
  List<UploadJob> _pictures = [];
  List<ImagesObject> listImages = [];

  @override
  void initState() {
    Ads.showPopupAd();
    if (this.widget.createdThread != null) {
      thread = this.widget.createdThread;
      this.widget.createdThread.imagesObject.forEach((element) {
        var _uploadJob = UploadJob();
        _uploadJob.storageReference =
            FirebaseStorage().ref().child(element.path);
        _pictures.add(_uploadJob);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Create a new thread: ${thread.id}");
    return Scaffold(
        backgroundColor: CareerPlannerTheme.neutralBackground,
        appBar: AppBar(
          backgroundColor: CareerPlannerTheme.neutralBackground,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FlatButton.icon(
                  onPressed: save,
                  icon: Icon(Icons.save),
                  label: Text('Lưu',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.bold))),
            )
          ],
        ),
        body: ListView(children: [
          FormBuilder(
            key: _fbKey,
            initialValue: thread.toJson(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: "title",
                    autofocus: true,
                    maxLines: null,
                    style: GoogleFonts.robotoSlabTextTheme()
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                    decoration: InputDecoration(
                        labelText: "Tiêu Đề",
                        hintText: 'Nhập tiêu đề thảo luận'),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  SizedBox(height: 32),
                  PictureUploadWidget(
                    onPicturesChange: pictureCallback,
                    initialImages: _pictures,
                    settings: PictureUploadSettings(
                        uploadDirectory: '/threads/${thread.id}/',
                        onErrorFunction: onErrorCallback),
                    buttonStyle:
                        PictureUploadButtonStyle(width: 100, height: 100),
                    buttonText: 'Tải ảnh lên',
                    enabled: true,
                  ),
                  SizedBox(height: 32),
                  FormBuilderTextField(
                    attribute: "description",
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.robotoSlabTextTheme()
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
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

  void onErrorCallback(error, stackTrace) {
    print(error);
    print(stackTrace);
  }

  void pictureCallback(
      {List<UploadJob> uploadJobs, bool pictureUploadProcessing}) {
    _pictures = uploadJobs;
    if (!pictureUploadProcessing) {
      _pictures.forEach((element) async {
        final storeRef = await element.storageReference;
        if (storeRef != null) {
          final name = await storeRef.getName();
          final path = await storeRef.getPath();
          final object = ImagesObject(id: name, path: path);
          listImages.add(object);
        }
      });
    }
  }

  void save() async {
    SVProgressHUD.show(status: '');
    thread.imagesObject = listImages;
    if (_fbKey.currentState.validate()) {
      saved = true;
      _fbKey.currentState.save();
      thread.title = _fbKey.currentState.value["title"];
      thread.description = _fbKey.currentState.value["description"];
      threadBloc.create(thread, this.widget.mentorUid).then((value) {
        SVProgressHUD.dismiss(delay: Duration(milliseconds: 1500));
        Navigator.of(context).pop();
      });
    }
    print(thread.toJson());
  }

  @override
  void dispose() {
    if (!saved) {
      _pictures.forEach((element) async {
        final _storeRef = element.storageReference;
        if (_storeRef != null) {
          await _storeRef.delete();
        }
      });
      print("Discard new thread");
    }
    super.dispose();
  }
}
