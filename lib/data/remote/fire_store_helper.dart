import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStoreHelper {
  Stream find1000Picture();

  Future<Query> findNextPicture(DocumentSnapshot nextDocument);

  Future<bool> updateVotePicture(String documentId, int vote);

  Future<bool> insertComment(String comment);
}