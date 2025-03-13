import 'package:ecommerce/common/bloc/button/button_state.dart';
import 'package:ecommerce/common/bloc/button/button_state_cubit.dart';
import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/button/reactive_button.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_req.dart';
import 'package:ecommerce/domain/auth/usecases/sign_in.dart';
import 'package:ecommerce/presentation/auth/pages/forgot_password.dart';
import 'package:ecommerce/presentation/home/pages/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EnterPassword extends StatelessWidget {
  UserSignInReq userSignInReq;
  EnterPassword({super.key, required this.userSignInReq});
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),

        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackbar = SnackBar(
                content: Text(
                  state.errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            if (state is ButtonSuccessState) {
              AppNavigator.pushAndRemove(context: context, widget: HomePage());
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signInText(context),
              SizedBox(height: 20),
              _passwordField(context),
              SizedBox(height: 20),
              _continueButton(context),
              SizedBox(height: 20),
              _forgetPasswordText(context),
            ],
          ),
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
                        widget: ForgotPasswordPage(),
                      ),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordCon,
      decoration: InputDecoration(hintText: "Enter Password"),
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          title: "Continue",
          onPressed: () {
            userSignInReq.password = _passwordCon.text;
            context.read<ButtonStateCubit>().execute(
              usecase: SignInUseCase(),
              params: userSignInReq,
            );
          },
        );
      },
    );
  }
}
