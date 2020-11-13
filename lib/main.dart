import 'package:careerplanner/util/ads_helper.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sentry/flutter_sentry.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/admob/admob_bloc.dart';

// void main() {
//   runApp(App());
// }

Future<void> main() => FlutterSentry.wrap(
      () async {
        runApp(App());
      },
      dsn:
          'https://1c7798597c8b44878c2b81428b742908@o353025.ingest.sentry.io/5440168',
    );

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var paddingBottom = 56.0;
  @override
  void initState() {
    admobBloc.showBannerAd(state: false);
    super.initState();
    Ads.showBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    MaterialColor primarySwatch =
        createMaterialColor(CareerPlannerTheme.primaryColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.startupRoute,
      builder: (context, widget) {
        final mediaQuery = MediaQuery.of(context);
        return StreamBuilder(
          stream: admobBloc.bannerAdInit,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return Container(
                  color: CareerPlannerTheme.primaryColor,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: paddingBottom),
                    child: SafeArea(child: widget),
                  ));
            }
            return widget;
          },
        );
      },
      theme: ThemeData(
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.lexendDecaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
