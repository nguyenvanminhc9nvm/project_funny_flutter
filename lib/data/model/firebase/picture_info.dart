class PictureInfo {
  final String documentId;
  final String caption;
  final String imageUrl;
  final int votes;

  PictureInfo(this.documentId, this.caption, this.imageUrl, this.votes);

  factory PictureInfo.fromJson(String documentId, dynamic json) {
    return PictureInfo(documentId, json['caption'] as String,
        json['image'] as String, json['votes'] as int);
  }
}
