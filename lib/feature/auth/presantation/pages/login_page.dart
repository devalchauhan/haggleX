import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/presantation/cubit/login_cubit.dart';
import 'package:hagglex/feature/auth/presantation/widgets/login_widgets.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatelessWidget {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoggedIn) {
            Navigator.pushReplacementNamed(context, MAIN_ROUTE);
          } else if (state is LoginProcessing) {
            emailFocusNode.unfocus();
            passwordFocusNode.unfocus();
          } else if (state is LoginError) {
            Toast.show(state.error, context,
                duration: 3,
                backgroundColor: Colors.red,
                gravity: Toast.BOTTOM);
          }
        },
        child: Stack(
          children: [
            Background(),
            LoginBody(
                emailFocusNode: emailFocusNode,
                emailController: emailController,
                passwordFocusNode: passwordFocusNode,
                passwordController: passwordController)
          ],
        ),
      ),
    );
  }
}
