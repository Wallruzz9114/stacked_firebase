import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/core/startup_view_model.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  ViewModelBuilder<StartUpViewModel> build(BuildContext context) =>
      ViewModelBuilder<StartUpViewModel>.reactive(
        builder: (BuildContext context, StartUpViewModel model, Widget child) =>
            Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 100,
                  child: Image.asset('assets/images/icon_large.png'),
                ),
                CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (StartUpViewModel model) => model.handleStartUpLogic(),
      );
}
