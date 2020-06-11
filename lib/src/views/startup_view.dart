import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/core/startup_view_model.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  ViewModelBuilder<StartupViewModel> build(BuildContext context) =>
      ViewModelBuilder<StartupViewModel>.reactive(
        builder: (BuildContext context, StartupViewModel model, Widget child) =>
            Scaffold(
          body: const Center(
            child: Text('Start up view'),
          ),
          floatingActionButton:
              FloatingActionButton(onPressed: () => model.goHome()),
        ),
        viewModelBuilder: () => StartupViewModel(),
      );
}
