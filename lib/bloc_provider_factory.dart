import 'package:project_funny_flutter/ui/base/base_bloc.dart';
import 'package:project_funny_flutter/ui/home/animals/animals_bloc.dart';
import 'package:project_funny_flutter/ui/home/games/games_bloc.dart';
import 'package:project_funny_flutter/ui/home/gif/gif_bloc.dart';
import 'package:project_funny_flutter/ui/home/home_bloc.dart';
import 'package:project_funny_flutter/ui/home/picture/picture_bloc.dart';
import 'package:project_funny_flutter/ui/menu/feedback/feedback_bloc.dart';
import 'package:project_funny_flutter/ui/on_boarding/on_boarding_bloc.dart';
import 'package:project_funny_flutter/ui/splash/splash_bloc.dart';

class BlocProviderFactory {
  B createBlocClass<B extends BaseBloc>(Type type) {
    switch (type) {
      case SplashBloc:
        return SplashBloc() as B;
      case OnBoardingBloc:
        return OnBoardingBloc() as B;
      case HomeBloc:
        return HomeBloc() as B;
      case GifBloc:
        return GifBloc() as B;
      case PictureBloc:
        return PictureBloc() as B;
      case FeedbackBloc:
        return FeedbackBloc() as B;
      case AnimalsBloc:
        return AnimalsBloc() as B;
      case GamesBloc:
        return GamesBloc() as B;
      default:
        throw "Unknown block class: $type";
    }
  }
}