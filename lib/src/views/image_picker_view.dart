import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/core/image_picker_view_model.dart';

class ImagePickerView extends StatelessWidget {
  const ImagePickerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImagePickerViewModel>.reactive(
      builder:
          (BuildContext context, ImagePickerViewModel model, Widget child) =>
              Scaffold(
        body: !model.hasSelectedImage
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.blue,
                    child: const Text('Pick an image'),
                    onPressed: () => model.selectImage(fromGallery: true),
                  ),
                  MaterialButton(
                    color: Colors.yellow,
                    child: const Text('Take an image'),
                    onPressed: () => model.selectImage(fromGallery: false),
                  ),
                ],
              )
            : model.isBusy
                ? const CircularProgressIndicator()
                : Image.network(model.selectedImage.path),
      ),
      viewModelBuilder: () => ImagePickerViewModel(),
    );
  }
}
