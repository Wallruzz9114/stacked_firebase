import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/models/routes.dart';
import 'package:stacked_firebase/src/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    final dynamic authenticationResult =
        await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (authenticationResult is bool) {
      if (authenticationResult) {
        _navigationService.navigateTo(Routes.homeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: authenticationResult as String,
      );
    }
  }
}
