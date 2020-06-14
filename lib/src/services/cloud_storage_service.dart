import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_firebase/src/models/cloud_storage_result.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String title,
  }) async {
    final String imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    final StorageUploadTask uploadTask =
        firebaseStorageRef.putFile(imageToUpload);
    final StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
    final dynamic downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      final String url = downloadUrl.toString();

      return CloudStorageResult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
    }

    return null;
  }

  Future<dynamic> deleteImage(String imageFileName) async {
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> getImage({bool fromGallery}) {
    return ImagePicker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
  }
}
