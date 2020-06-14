import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/constants.dart';
import 'package:stacked_firebase/src/components/input_field.dart';
import 'package:stacked_firebase/src/core/create_post_view_model.dart';
import 'package:stacked_firebase/src/models/post.dart';

class CreatePostView extends StatelessWidget {
  CreatePostView({Key key, this.edittingPost}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final Post edittingPost;

  @override
  ViewModelBuilder<CreatePostViewModel> build(BuildContext context) =>
      ViewModelBuilder<CreatePostViewModel>.reactive(
        builder:
            (BuildContext context, CreatePostViewModel model, Widget child) =>
                Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.isBusy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
            onPressed: () {
              if (!model.isBusy) {
                model.addPost(title: titleController.text);
              }
            },
            backgroundColor: !model.isBusy
                ? Theme.of(context).primaryColor
                : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                const Text('Create Post', style: TextStyle(fontSize: 26)),
                verticalSpaceMedium,
                InputField(placeholder: 'Title', controller: titleController),
                verticalSpaceMedium,
                const Text('Post Image'),
                verticalSpaceSmall,
                GestureDetector(
                  onTap: () => model.selectImage(fromGallery: true),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: model.selectedImage == null
                        ? Text(
                            'Tap to add post image',
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        : Image.file(model.selectedImage),
                  ),
                )
              ],
            ),
          ),
        ),
        viewModelBuilder: () => CreatePostViewModel(),
        onModelReady: (CreatePostViewModel model) {
          // update the text in the controller
          titleController.text = edittingPost?.title ?? '';
          model.setEdittingPost(edittingPost);
        },
      );
}
