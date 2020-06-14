import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_firebase/src/services/analytics_service.dart';
import 'package:stacked_firebase/src/services/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  String _selectedRole = 'Select a User Role';
  String get selectedUserRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role.toString();
    notifyListeners();
  }

  Future<void> signUp({
    @required String fullName,
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    final dynamic authenticationResult =
        await _authenticationService.signUpWithEmail(
      fullName: fullName,
      email: email,
      password: password,
      role: _selectedRole,
    );

    setBusy(false);

    if (authenticationResult is bool) {
      if (authenticationResult) {
        _analyticsService.logSignUp();
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
