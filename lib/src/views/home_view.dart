import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/constants.dart';
import 'package:stacked_firebase/src/components/post_item.dart';
import 'package:stacked_firebase/src/core/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  ViewModelBuilder<HomeViewModel> build(BuildContext context) =>
      ViewModelBuilder<HomeViewModel>.reactive(
        builder: (BuildContext context, HomeViewModel model, Widget child) =>
            Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: !model.isBusy
                ? Icon(Icons.add)
                : const CircularProgressIndicator(),
            onPressed: model.navigateToCreateView,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(35),
                Row(
                  children: <Widget>[
                    SizedBox(
                        height: 20,
                        child: Image.asset('assets/images/title.png')),
                  ],
                ),
                Expanded(
                  child: model.posts != null
                      ? ListView.builder(
                          itemCount: model.posts.length,
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () => model.editPost(index),
                            child: PostItem(
                              post: model.posts[index],
                              onDeleteItem: () => model.deletePost(index),
                            ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (HomeViewModel model) => model.listenToPosts(),
      );
}
