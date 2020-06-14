import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/models/cloud_storage_result.dart';
import 'package:stacked_firebase/src/models/post.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_firebase/src/services/analytics_service.dart';
import 'package:stacked_firebase/src/services/authentication_service.dart';
import 'package:stacked_firebase/src/services/cloud_storage_service.dart';
import 'package:stacked_firebase/src/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';

class CreatePostViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  Post _edittingPost;
  bool get _editting => _edittingPost != null;

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Future<void> selectImage({@required bool fromGallery}) async {
    final File tempImage = await runBusyFuture(
        _cloudStorageService.getImage(fromGallery: fromGallery)) as File;

    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  Future<dynamic> addPost({@required String title}) async {
    setBusy(true);

    CloudStorageResult cloudStorageResult;

    if (!_editting) {
      cloudStorageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage, title: title);
    }

    dynamic result;

    if (!_editting) {
      result = await _firestoreService.addPost(Post(
        title: title,
        userId: _authenticationService.currentUser.id,
        imageUrl: cloudStorageResult.imageUrl,
        imageFileName: cloudStorageResult.imageFileName,
        isDeleted: false,
      ));

      await _analyticsService.logPostCreated(hasImage: _selectedImage != null);
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _edittingPost.userId,
        documentId: _edittingPost.documentId,
        imageUrl: _edittingPost.imageUrl,
        imageFileName: _edittingPost.imageFileName,
        isDeleted: false,
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
