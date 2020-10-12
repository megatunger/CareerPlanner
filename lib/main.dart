import 'package:careerplanner/util/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_sentry/flutter_sentry.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(App());
  SharedPreferences.getInstance().then((value) {
    value.clear();
  });
}

// Future<void> main() => FlutterSentry.wrap(
//       () async {
//         // Optionally other initializers, like Firebase.
//
//         runApp(App());
//       },
//       dsn:
//           'https://1c7798597c8b44878c2b81428b742908@o353025.ingest.sentry.io/5440168',
//     );

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.startupRoute,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.lexendDecaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
