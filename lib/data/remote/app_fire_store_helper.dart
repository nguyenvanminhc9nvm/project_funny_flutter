import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_funny_flutter/data/remote/fire_store_helper.dart';
import 'package:project_funny_flutter/utils/constant/constant.dart';

class AppFireStoreHelper extends FireStoreHelper {
  static final AppFireStoreHelper _singleton = AppFireStoreHelper.internal();

  factory AppFireStoreHelper() {
    return _singleton;
  }

  AppFireStoreHelper.internal();

  @override
  Stream find1000Picture() async* {
    yield (FirebaseFirestore.instance.collection(tbPicture).limit(3).snapshots());
  }

  @override
  Future<Query> findNextPicture(DocumentSnapshot nextDocument) {
    final pictures = FirebaseFirestore.instance
        .collection(tbPicture)
        .startAfterDocument(nextDocument)
        .limit(3);
    return Future.value(pictures);
  }

  @override
  Future<bool> updateVotePicture(String documentId, int vote) async {
    await FirebaseFirestore.instance
        .collection(tbPicture)
        .doc(documentId)
        .update({"votes": vote});
    return Future.value(true);
  }

  @override
  Future<bool> insertComment(String comment) {
    final feedback = FirebaseFirestore.instance
        .collection("tb_feedback");
    feedback.add({"comment": comment});
    return Future.value(true);
  }
}
