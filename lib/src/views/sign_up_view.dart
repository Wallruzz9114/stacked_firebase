import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/constants.dart';
import 'package:stacked_firebase/src/components/busy_button.dart';
import 'package:stacked_firebase/src/components/input_field.dart';
import 'package:stacked_firebase/src/core/sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  ViewModelBuilder<SignUpViewModel> build(BuildContext context) =>
      ViewModelBuilder<SignUpViewModel>.reactive(
        builder: (BuildContext context, SignUpViewModel model, Widget child) =>
            Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Sign Up', style: TextStyle(fontSize: 38)),
                verticalSpaceLarge,
                InputField(placeholder: 'Email', controller: emailController),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                  additionalNote:
                      'Password has to be a minimum of 6 characters.',
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <BusyButton>[
                    BusyButton(
                      title: 'Sign Up',
                      onPressed: () {
                        model.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        viewModelBuilder: () => SignUpViewModel(),
      );
}
