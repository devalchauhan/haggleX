import 'package:flutter/material.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/text_style.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key key,
    @required this.controller,
    this.hintText, this.focusNode,
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
