import 'package:project_funny_flutter/ui/base/base_bloc.dart';

class FeedbackBloc extends BaseBloc {
  void insertComment(String comment) {
    dataManager.insertComment(comment);
  }
}