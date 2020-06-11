import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked_firebase/src/models/home_view_arguments.dart';
import 'package:stacked_firebase/src/models/routes.dart';
import 'package:stacked_firebase/src/models/startup_view_arguments.dart';
import 'package:stacked_firebase/src/views/home_view.dart';
import 'package:stacked_firebase/src/views/startup_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final Object args = settings.arguments;

  switch (settings.name) {
    case Routes.startupViewRoute:
      if (hasInvalidArgs<StartupViewArguments>(args)) {
        return misTypedArgsRoute<StartupViewArguments>(args);
      }
      final StartupViewArguments typedArgs =
          args as StartupViewArguments ?? StartupViewArguments();
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => StartupView(key: typedArgs.key),
        settings: settings,
      );
    case Routes.homeViewRoute:
      if (hasInvalidArgs<HomeViewArguments>(args)) {
        return misTypedArgsRoute<HomeViewArguments>(args);
      }
      final HomeViewArguments typedArgs =
          args as HomeViewArguments ?? HomeViewArguments();
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HomeView(key: typedArgs.key),
        settings: settings,
      );
    default:
      return unknownRoutePage(settings.name);
  }
}
