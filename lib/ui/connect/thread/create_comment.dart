import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/bloc/thread/thread_bloc.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CreateComment extends StatefulWidget {
  CreateComment({Key key, this.thread}) : super(key: key);
  final ThreadObject thread;
  @override
  _CreateCommentState createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<UploadJob> _pictures = [];
  List<ImagesObject> listImages = [];
  bool saved = false;
  final comment =
      CommentObject(id: Uuid().v4(), uid: accountBloc.currentUser().uid);

  @override
  Widget build(BuildContext context) {
    print("Create new comment: ${comment.id}");
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close)),
          FlatButton.icon(
              onPressed: save,
              icon: Icon(Icons.send),
              label: Text('Trả lời',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold)))
        ]),
      ),
      FormBuilder(
        key: _fbKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PictureUploadWidget(
                onPicturesChange: pictureCallback,
                initialImages: _pictures,
                settings: PictureUploadSettings(
                    uploadDirectory:
                        '/threads/${this.widget.thread.id}/comments/',
                    onErrorFunction: onErrorCallback),
                buttonStyle: PictureUploadButtonStyle(width: 100, height: 100),
                buttonText: 'Tải ảnh lên',
                enabled: true,
              ),
              SizedBox(height: 32),
              FormBuilderTextField(
                attribute: "body",
                keyboardType: TextInputType.text,
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
      SizedBox(height: 64),
    ]);
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
    comment.imagesObject = listImages;
    if (_fbKey.currentState.validate()) {
      saved = true;
      _fbKey.currentState.save();
      comment.body = _fbKey.currentState.value["body"];
      threadBloc.createComment(this.widget.thread, comment).then((value) {
        SVProgressHUD.dismiss(delay: Duration(milliseconds: 1500));
        Navigator.of(context).pop();
      });
    }
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
      print("Discard new comment");
    }
    super.dispose();
  }
}
