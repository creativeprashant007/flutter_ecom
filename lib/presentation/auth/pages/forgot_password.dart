import 'package:ecommerce/common/bloc/button/button_state.dart';
import 'package:ecommerce/common/bloc/button/button_state_cubit.dart';
import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/button/reactive_button.dart';
import 'package:ecommerce/domain/auth/usecases/reset_email.dart';
import 'package:ecommerce/presentation/auth/pages/password_reset_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(),
      body: BlocListener<ButtonStateCubit, ButtonState>(
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
            AppNavigator.push(
              context: context,
              widget: PasswordResetEmailPage(),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _forgotPasswordText(context),
              SizedBox(height: 20),
              _emailField(context),
              SizedBox(height: 20),
              _continueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordText(BuildContext context) {
    return Text(
      "Forgot Password",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailCon,
      decoration: InputDecoration(hintText: "Enter Email"),
    );
  }

  Widget _continueButton(context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          title: "Continue",
          onPressed: () {
            context.read<ButtonStateCubit>().execute(
              params: _emailCon.text,
              usecase: ResetEmailUseCase(),
            );
          },
        );
      },
    );
  }
}
