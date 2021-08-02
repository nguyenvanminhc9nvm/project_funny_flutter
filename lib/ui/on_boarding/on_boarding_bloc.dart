import 'package:project_funny_flutter/data/model/local/on_boar.dart';
import 'package:project_funny_flutter/ui/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class OnBoardingBloc extends BaseBloc {
  Future<List<OnBoar>> doGetListOnBoar() {
    return dataManager.doGetListOnBoarding();
  }

  void loggedInToApp() {
    dataManager.setFirstTimeLogin(true);
  }
}
