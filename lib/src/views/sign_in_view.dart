import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/constants.dart';
import 'package:stacked_firebase/src/components/busy_button.dart';
import 'package:stacked_firebase/src/components/input_field.dart';
import 'package:stacked_firebase/src/components/text_link.dart';
import 'package:stacked_firebase/src/core/sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  ViewModelBuilder<SignInViewModel> build(BuildContext context) =>
      ViewModelBuilder<SignInViewModel>.reactive(
        builder: (BuildContext context, SignInViewModel model, Widget child) =>
            Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Image.asset('assets/images/title.png'),
                ),
                InputField(
                  placeholder: 'Email',
                  controller: emailController,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <BusyButton>[
                    BusyButton(
                      title: 'Login',
                      onPressed: () {
                        model.signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    )
                  ],
                ),
                verticalSpaceMedium,
                TextLink(
                  'Create an Account if you\'re new.',
                  onPressed: () {
                    model.navigateToSignUp();
                  },
                )
              ],
            ),
          ),
        ),
        viewModelBuilder: () => SignInViewModel(),
      );
}
