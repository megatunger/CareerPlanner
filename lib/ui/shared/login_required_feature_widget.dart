import 'package:flutter/material.dart';

class LoginRequiredFeatureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.white.withOpacity(0.08), BlendMode.dstIn),
          image: AssetImage("assets/illustrations/4086124.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset("assets/illustrations/sign-in-4.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: Text(
              'Hãy đăng nhập để sử dụng chức năng này bạn nhé!',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )),
    ));
  }
}
