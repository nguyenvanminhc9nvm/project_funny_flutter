import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_funny_flutter/data/model/firebase/picture_info.dart';
import 'package:project_funny_flutter/ui/base/base_bloc.dart';

class PictureBloc extends BaseBloc {
  late QuerySnapshot collectionState;

  Stream<List<PictureInfo>> fetchPicture() async* {
    List<PictureInfo> pictureInfo = [];
    await dataManager.find1000Picture().listen((value) {
      collectionState = value;
      value.docs.forEach((element) {
        pictureInfo.add(PictureInfo.fromJson(element.id, element.data()));
      });
    });
    yield (pictureInfo);
  }

  void updateVotePicture(String documentId, int vote) {
    dataManager.updateVotePicture(documentId, vote);
  }
}
