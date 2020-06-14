import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/services/cloud_storage_service.dart';

class ImagePickerViewModel extends BaseViewModel {
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  File _selectedImage;

  bool get hasSelectedImage => _selectedImage != null;

  File get selectedImage => _selectedImage;

  Future<File> selectImage({@required bool fromGallery}) async =>
      _selectedImage = await runBusyFuture(
          _cloudStorageService.getImage(fromGallery: fromGallery)) as File;
}
