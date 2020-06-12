import 'package:email_validator/email_validator.dart';
import 'package:stacked/stacked.dart';

class ValidationViewModel extends BaseViewModel {
  String _email = '';
  String _mobileNumber = '';
  String _username = '';

  bool get canSubmit =>
      _username.length > 3 &&
      (EmailValidator.validate(_email) || _mobileNumber.length > 3);

  void setName(String username) {
    _username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setMobileNumber(String mobileNumber) {
    _mobileNumber = mobileNumber;
    notifyListeners();
  }
}
