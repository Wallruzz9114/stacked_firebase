import 'package:flutter/foundation.dart';

class Post {
  Post({
    @required this.userId,
    @required this.title,
    this.documentId,
    this.imageUrl,
    this.imageFileName,
    this.isDeleted,
  });

  final String title;
  final String imageUrl;
  final String userId;
  final String documentId;
  final String imageFileName;
  bool isDeleted;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': userId,
        'title': title,
        'imageUrl': imageUrl,
        'imageFileName': imageFileName,
        'isDeleted': isDeleted,
      };

  static Post fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) {
      return null;
    }

    return Post(
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      userId: map['userId'] as String,
      imageFileName: map['imageFileName'] as String,
      documentId: documentId,
      isDeleted: map['isDeleted'] as bool,
    );
  }
}
