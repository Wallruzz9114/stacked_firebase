import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_firebase/src/core/validation_view_model.dart';

void main() {
  group('ValidationViewmodelTest - ', () {
    group('canSubmit - ', () {
      test('When constructed canSubmit should be false', () {
        final ValidationViewModel validationViewModel = ValidationViewModel();

        expect(validationViewModel.canSubmit, false);
      });

      test('When setName is called and no contact is set, it should be false',
          () {
        final ValidationViewModel validationViewModel = ValidationViewModel();

        validationViewModel.setName('Jose');

        expect(validationViewModel.canSubmit, false);
      });

      test('When setName is called and valid email is set, should be true', () {
        final ValidationViewModel validationViewModel = ValidationViewModel();

        validationViewModel.setName('Jose');
        validationViewModel.setEmail('jose@gmail.com');
        validationViewModel.setMobileNumber('4033702416');

        expect(validationViewModel.canSubmit, true);
      });

      test('When setName is called and invalid email is set, should be false',
          () {
        final ValidationViewModel validationViewModel = ValidationViewModel();

        validationViewModel.setName('FilledStacks');
        validationViewModel.setEmail('dane@tested');

        expect(validationViewModel.canSubmit, false);
      });

      test(
          'When setName is called and valid mobileNumber is set, should be true',
          () {
        final ValidationViewModel validationViewModel = ValidationViewModel();

        validationViewModel.setName('FilledStacks');
        validationViewModel.setMobileNumber('05454848');

        expect(validationViewModel.canSubmit, true);
      });

      test(
          'When setName is called and mobileNumber is invalid, should be false',
          () {
        final ValidationViewModel validationViewModel = ValidationViewModel();

        validationViewModel.setName('FilledStacks');
        validationViewModel.setMobileNumber('0');

        expect(validationViewModel.canSubmit, false);
      });

      test('When setName is called should notifyListeners to rebuild UI', () {
        final ValidationViewModel validationViewModel = ValidationViewModel();
        bool called = false;

        validationViewModel.addListener(() {
          called = true;
        });
        validationViewModel.setName('FilledStacks');

        expect(called, true);
      });
    });
  });
}
