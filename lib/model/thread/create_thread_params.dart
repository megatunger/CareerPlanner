import 'package:careerplanner/model/thread/thread_object.dart';

class CreateThreadParams {
  final ThreadObject createdThread;
  final String mentorUid;

  CreateThreadParams({this.createdThread, this.mentorUid});
}
