import 'package:flutter/material.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/text_style.dart';

class RegistrationTextField extends StatelessWidget {
  const RegistrationTextField({
    Key key,
    @required this.controller,
    this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kColorBlack,
      controller: controller,
      decoration: kInputDecorationRegistration.copyWith(hintText: hintText),
      style: kTextStyle.copyWith(color: kColorBlack),
    );
  }
}

class RegistrationReferralTextField extends StatelessWidget {
  const RegistrationReferralTextField({
    Key key,
    @required this.controller,
    this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kColorBlack,
      controller: controller,
      decoration: kInputDecorationRegistration.copyWith(
          hintText: hintText, hintStyle: kRegistrationReferralHintTextStyle),
      style: kTextStyle.copyWith(color: kColorBlack),
    );
  }
}


class RegistrationGradientButton extends StatelessWidget {
  final Function onClick;
  final String btnText;

  const RegistrationGradientButton({
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
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                kColorPrimary,
                kColorSecondary,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            btnText,
            style: kTextStyle.copyWith(
              fontSize: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}

