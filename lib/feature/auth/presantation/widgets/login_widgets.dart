import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/presantation/cubit/login_cubit.dart';
import 'package:hagglex/feature/auth/domain/usecases/login.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key key,
    @required this.controller,
    this.hintText,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      cursorColor: kColorWhite,
      controller: controller,
      decoration: kInputDecorationLogin.copyWith(hintText: hintText),
      style: kTextStyle,
    );
  }
}

class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({
    Key key,
    @required this.controller,
    this.hintText,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;

  @override
  _LoginPasswordFieldState createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      cursorColor: kColorWhite,
      obscureText: !_passwordVisible,
      controller: widget.controller,
      decoration: kInputDecorationLogin.copyWith(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      style: kTextStyle,
    );
  }
}

class LoginGoldenButton extends StatelessWidget {
  final Function onClick;
  final String btnText;

  const LoginGoldenButton({
    Key key,
    this.onClick,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: kColorTextGolden,
            border: Border.all(
              color: kColorTextGolden,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            btnText,
            style: kTextStyle.copyWith(
              fontSize: 15.0,
              color: kColorBlack,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key key,
    @required this.emailFocusNode,
    @required this.emailController,
    @required this.passwordFocusNode,
    @required this.passwordController,
  }) : super(key: key);

  final FocusNode emailFocusNode;
  final TextEditingController emailController;
  final FocusNode passwordFocusNode;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      child: Container(
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

                    BlocProvider.of<LoginCubit>(context).callLogin(LoginParams(
                        loginUser:
                            LoginUser(email: email, password: password)));
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
      ),
    );
  }
}
