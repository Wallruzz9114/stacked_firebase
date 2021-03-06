abstract class Routes {
  static const String startUpViewRoute = '/';
  static const String homeViewRoute = '/home-view-route';
  static const String signInViewRoute = '/sign-in-view-route';
  static const String signUpViewRoute = '/sign-up-view-route';
  static const String createPostViewRoute = '/create-post-view-route';
  static const String imagePickerViewRoute = '/image-picker-view-route';

  static const Set<String> all = <String>{
    startUpViewRoute,
    homeViewRoute,
    signInViewRoute,
    signUpViewRoute,
    createPostViewRoute,
    imagePickerViewRoute,
  };
}
