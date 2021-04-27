import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'color.dart';

const kFontBasisGrotesque = 'BasisGrotesque';

const kTextStyle = TextStyle(
  color: kColorWhite,
  fontSize: 20.0,
  fontFamily: kFontBasisGrotesque,
  fontWeight: FontWeight.bold,
);
const kTextStyleNormal = TextStyle(
  color: kColorBlack,
  fontSize: 20.0,
  fontFamily: kFontBasisGrotesque,
  fontWeight: FontWeight.normal,
);

const kLoginHintTextStyle = TextStyle(
  color: kColorWhite,
  fontSize: 15.0,
  fontFamily: kFontBasisGrotesque,
  fontWeight: FontWeight.normal,
);

const kRegistrationHintTextStyle = TextStyle(
  color: kColorBlack,
  fontSize: 15.0,
  fontFamily: kFontBasisGrotesque,
  fontWeight: FontWeight.normal,
);

const kRegistrationReferralHintTextStyle = TextStyle(
  color: kColorBlack40,
  fontSize: 15.0,
  fontFamily: kFontBasisGrotesque,
  fontWeight: FontWeight.normal,
);

const kInputDecorationLogin = InputDecoration(
  hintStyle: kLoginHintTextStyle,
  isDense: true,
  contentPadding:
      EdgeInsets.only(bottom: 5.0, left: 0.0, right: 10.0, top: 10.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kColorWhite),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kColorWhite),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: kColorWhite),
  ),
);

const kInputDecorationSearch = InputDecoration(
  fillColor: kColorWhite20,
  hintStyle: kLoginHintTextStyle,
  isDense: true,
  contentPadding:
      EdgeInsets.only(bottom: 5.0, left: 30.0, right: 30.0, top: 10.0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: Colors.transparent, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    borderSide: BorderSide(color: Colors.transparent),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
  filled: true,
);

const kInputDecorationRegistration = InputDecoration(
  hintStyle: kRegistrationHintTextStyle,
  isDense: true,
  contentPadding:
      EdgeInsets.only(bottom: 5.0, left: 0.0, right: 10.0, top: 10.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kColorBlack),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kColorBlack),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: kColorBlack),
  ),
);
