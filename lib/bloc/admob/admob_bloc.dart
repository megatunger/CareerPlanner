import 'package:rxdart/rxdart.dart';

class AdmobBloc {
  final BehaviorSubject<bool> _bannerAdInit = BehaviorSubject<bool>();

  showBannerAd({bool state}) async {
    if (state) {
      _bannerAdInit.sink.add(true);
    } else {
      _bannerAdInit.sink.add(false);
    }
  }

  dispose() {
    _bannerAdInit.close();
  }

  BehaviorSubject<bool> get bannerAdInit => _bannerAdInit;
}

final admobBloc = AdmobBloc();
