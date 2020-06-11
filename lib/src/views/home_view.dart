import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/core/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  ViewModelBuilder<HomeViewModel> build(BuildContext context) =>
      ViewModelBuilder<HomeViewModel>.reactive(
        builder: (BuildContext context, HomeViewModel model, Widget child) =>
            Scaffold(
          body: Center(
            child: Text(model.title),
          ),
          floatingActionButton:
              FloatingActionButton(onPressed: model.updateCounter),
        ),
        viewModelBuilder: () => HomeViewModel(),
      );
}
