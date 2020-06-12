import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/core/validation_view_model.dart';

class ValidationView extends StatelessWidget {
  const ValidationView({Key key}) : super(key: key);

  @override
  ViewModelBuilder<ValidationViewModel> build(BuildContext context) =>
      ViewModelBuilder<ValidationViewModel>.reactive(
        builder:
            (BuildContext context, ValidationViewModel model, Widget child) =>
                const Scaffold(),
        viewModelBuilder: () => ValidationViewModel(),
      );
}
