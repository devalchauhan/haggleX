import 'package:flutter/material.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/text_style.dart';

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
