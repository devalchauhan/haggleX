import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/login.dart';
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
            Navigator.pushReplacementNamed(context, DASHBOARD_ROUTE);
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
            Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: kTextStyle.copyWith(fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  LoginTextField(
                    focusNode: emailFocusNode,
                    controller: emailController,
                    hintText: 'Email Address',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  LoginPasswordField(
                    focusNode: passwordFocusNode,
                    controller: passwordController,
                    hintText: 'Password (Min. 8 characters)',
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: kLoginHintTextStyle.copyWith(fontSize: 10.0),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginProcessing) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return LoginGoldenButton(
                        onClick: () {
                          String email = emailController.text;
                          String password = passwordController.text;

                          BlocProvider.of<LoginCubit>(context).callLogin(
                              LoginParams(
                                  loginUser: LoginUser(
                                      email: email, password: password)));
                        },
                        btnText: 'LOG IN',
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, REGISTRATION_ROUTE);
                      },
                      child: Text(
                        'New User?Create a new account',
                        style: kLoginHintTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
