abstract class Routes {
  static const String startupViewRoute = '/';
  static const String homeViewRoute = '/home-view-route';
  static const String signInViewRoute = '/sign-in-view-route';
  static const String signUpViewRoute = '/sign-up-view-route';

  static const Set<String> all = <String>{
    startupViewRoute,
    homeViewRoute,
    signInViewRoute,
    signUpViewRoute
  };
}
