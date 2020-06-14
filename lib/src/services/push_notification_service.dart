import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_services/stacked_services.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<dynamic> initialise() async {
    if (Platform.isIOS) {
      // request permissions if we're on iOS
      _firebaseMessaging
          .requestNotificationPermissions(const IosNotificationSettings());
    }

    _firebaseMessaging.configure(
      // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      // Called when the app has been closed comlpetely and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _serialiseAndNavigate(message);
      },
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _serialiseAndNavigate(message);
      },
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    final dynamic notificationData = message['data'];
    final dynamic view = notificationData['view'];

    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
        _navigationService.navigateTo(Routes.createPostViewRoute);
      }
    }
  }
}
