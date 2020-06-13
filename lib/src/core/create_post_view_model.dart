import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/models/post.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_firebase/src/services/authentication_service.dart';
import 'package:stacked_firebase/src/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';

class CreatePostViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Post _edittingPost;

  bool get _editting => _edittingPost != null;

  Future<dynamic> addPost({@required String title}) async {
    setBusy(true);

    dynamic result;

    if (!_editting) {
      result = await _firestoreService.addPost(
          Post(title: title, userId: _authenticationService.currentUser.id));
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.navigateTo(Routes.homeViewRoute);
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
