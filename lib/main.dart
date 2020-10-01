import 'package:careerplanner/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_sentry/flutter_sentry.dart';

void main() {
  runApp(App());
  DefaultCacheManager manager = new DefaultCacheManager();
  manager.emptyCache();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.startupRoute,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
