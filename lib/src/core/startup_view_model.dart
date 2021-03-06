import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_firebase/src/services/authentication_service.dart';
import 'package:stacked_firebase/src/services/push_notification_service.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  Future<void> handleStartUpLogic() async {
    // Register for push notifications
    await _pushNotificationService.initialise();

    final bool hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(Routes.homeViewRoute);
    } else {
      _navigationService.navigateTo(Routes.signInViewRoute);
    }
  }
}
