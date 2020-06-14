import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked_firebase/src/models/post.dart';
import 'package:stacked_firebase/src/models/routes/create_post_view_arguments.dart';
import 'package:stacked_firebase/src/models/routes/image_picker_view_arguments.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_firebase/src/models/routes/home_view_arguments.dart';
import 'package:stacked_firebase/src/models/routes/startup_view_arguments.dart';
import 'package:stacked_firebase/src/views/create_post_view.dart';
import 'package:stacked_firebase/src/views/home_view.dart';
import 'package:stacked_firebase/src/views/sign_in_view.dart';
import 'package:stacked_firebase/src/views/sign_up_view.dart';
import 'package:stacked_firebase/src/views/start_up_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final Object args = settings.arguments;

  switch (settings.name) {
    case Routes.signInViewRoute:
      return MaterialPageRoute<SignInView>(
        builder: (BuildContext context) => SignInView(),
        settings: settings,
      );
    case Routes.signUpViewRoute:
      return MaterialPageRoute<SignUpView>(
        builder: (BuildContext context) => SignUpView(),
        settings: settings,
      );
    case Routes.startUpViewRoute:
      if (hasInvalidArgs<StartUpViewArguments>(args)) {
        return misTypedArgsRoute<StartUpViewArguments>(args);
      }
      final StartUpViewArguments typedArgs =
          args as StartUpViewArguments ?? StartUpViewArguments();
      return MaterialPageRoute<StartUpView>(
        builder: (BuildContext context) => StartUpView(key: typedArgs.key),
        settings: settings,
      );
    case Routes.homeViewRoute:
      if (hasInvalidArgs<HomeViewArguments>(args)) {
        return misTypedArgsRoute<HomeViewArguments>(args);
      }
      final HomeViewArguments typedArgs =
          args as HomeViewArguments ?? HomeViewArguments();
      return MaterialPageRoute<HomeView>(
        builder: (BuildContext context) => HomeView(key: typedArgs.key),
        settings: settings,
      );
    case Routes.createPostViewRoute:
      if (hasInvalidArgs<CreatePostViewArguments>(args)) {
        return misTypedArgsRoute<CreatePostViewArguments>(args);
      }
      final CreatePostViewArguments typedArgs =
          args as CreatePostViewArguments ?? CreatePostViewArguments();
      final Post postToEdit = settings.arguments as Post;
      return MaterialPageRoute<CreatePostView>(
        builder: (BuildContext context) =>
            CreatePostView(key: typedArgs.key, edittingPost: postToEdit),
        settings: settings,
      );
    case Routes.imagePickerViewRoute:
      if (hasInvalidArgs<ImagePickerViewArguments>(args)) {
        return misTypedArgsRoute<ImagePickerViewArguments>(args);
      }
      final ImagePickerViewArguments typedArgs =
          args as ImagePickerViewArguments ?? ImagePickerViewArguments();
      final Post postToEdit = settings.arguments as Post;
      return MaterialPageRoute<CreatePostView>(
        builder: (BuildContext context) =>
            CreatePostView(key: typedArgs.key, edittingPost: postToEdit),
        settings: settings,
      );
    default:
      return unknownRoutePage(settings.name);
  }
}
