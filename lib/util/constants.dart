import 'package:firebase_database/firebase_database.dart';

class Constants {
  FirebaseDatabase database = FirebaseDatabase();

  init() {
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  }
}

final constants = Constants();
