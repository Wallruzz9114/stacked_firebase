import 'package:flutter/material.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/app/router.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_firebase/src/services/analytics_service.dart';
import 'package:stacked_firebase/src/views/sign_up_view.dart';
import 'package:stacked_services/stacked_services.dart';

class StackedFirebase extends StatelessWidget {
  @override
  MaterialApp build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stacked Firebase',
        initialRoute: Routes.startUpViewRoute,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 9, 202, 172),
          backgroundColor: const Color.fromARGB(255, 26, 27, 30),
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
        ),
        home: SignUpView(),
        onGenerateRoute: onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey
            as GlobalKey<NavigatorState>,
        navigatorObservers: <NavigatorObserver>[
          locator<AnalyticsService>().getAnalyticsObserver(),
        ],
      );
}
