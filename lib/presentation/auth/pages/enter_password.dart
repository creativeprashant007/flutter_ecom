import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce/presentation/auth/pages/forgot_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EnterPassword extends StatelessWidget {
  const EnterPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signInText(context),
            SizedBox(height: 20),
            _passwordField(context),
            SizedBox(height: 20),
            _continueButton(),
            SizedBox(height: 20),
            _forgetPasswordText(context),
          ],
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Text(
      "Sign in",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _forgetPasswordText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: "Forget password? "),
          TextSpan(
            text: "Reset",
            recognizer:
                TapGestureRecognizer()
                  ..onTap =
                      () => AppNavigator.push(
                        context: context,
                        widget: const ForgotPassword(),
                      ),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(decoration: InputDecoration(hintText: "Enter Password"));
  }

  Widget _continueButton() {
    return BasicAppButton(title: "Continue", onPressed: () {});
  }
}
