import 'package:project_funny_flutter/bloc_provider_factory.dart';
import 'package:project_funny_flutter/data/app_data_manager.dart';
import 'package:project_funny_flutter/data/data_manager.dart';

class Application {
  static final Application _singleton = Application.internal();
  late DataManager dataManager;
  late BlocProviderFactory blocProviderFactory;

  factory Application() {
    return _singleton;
  }

  Application.internal() {
    dataManager = AppDataManager();
    blocProviderFactory = BlocProviderFactory();
  }
}