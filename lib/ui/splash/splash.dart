import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_funny_flutter/ui/base/base_state.dart';
import 'package:project_funny_flutter/ui/splash/splash_bloc.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends BaseState<Splash, SplashBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          icLogo,
          width: 205.w,
          height: 177.h,
        ),
      ),
    );
  }

  @override
  void onListenerStream() {
    bloc.isFirstTimeSignIn.listen((value) async {
      await Future.delayed(Duration(milliseconds: 1500));
      if (value) {
        Navigator.pushReplacementNamed(context, home);
      } else {
        Navigator.pushReplacementNamed(context, onBoarding);
      }
    });
  }
}
