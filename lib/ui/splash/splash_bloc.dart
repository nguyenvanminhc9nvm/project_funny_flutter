import 'package:project_funny_flutter/ui/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc extends BaseBloc {
  BehaviorSubject<bool> isFirstTimeSignIn = BehaviorSubject();

  SplashBloc() {
    dataManager
        .getFirstTimeLogin()
        .then((value) => isFirstTimeSignIn.add(value));
  }
}
