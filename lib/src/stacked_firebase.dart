import 'package:flutter/material.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/app/router.dart';
import 'package:stacked_firebase/src/models/routes.dart';
import 'package:stacked_services/stacked_services.dart';

class StackedFirebase extends StatelessWidget {
  @override
  MaterialApp build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: Routes.startupViewRoute,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey
            as GlobalKey<NavigatorState>,
      );
}
