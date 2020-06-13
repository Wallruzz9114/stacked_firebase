import 'package:flutter/foundation.dart';
import 'package:stacked_firebase/src/models/post.dart';

class CreatePostViewArguments {
  CreatePostViewArguments({this.key, this.edittingPost});

  final Key key;
  final Post edittingPost;
}
