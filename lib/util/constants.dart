import 'package:firebase_database/firebase_database.dart';

class Constants {
  FirebaseDatabase database = FirebaseDatabase();

  init() {
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  }

  static final shownOnboardingScreen = 'SHOWN_ONBOARDING_SCREEN';
  static final showFavButtonGuideKey = 'SHOWN_FAVOURITE_BUTTON_GUIDELINE';

  static final outOfQuestions = '#out_of_questions';
}

final constants = Constants();
