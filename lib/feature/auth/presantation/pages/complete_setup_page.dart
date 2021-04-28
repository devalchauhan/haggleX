import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/presantation/widgets/login_widgets.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';

class CompleteSetupPage extends StatelessWidget {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/verify_check_gold.png',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Setup Complete',
                    style: kTextStyle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Thank you for setting up your HaggleX account',
                    style: kTextStyle.copyWith(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80.0,
            left: 30.0,
            right: 30.0,
            child: LoginGoldenButton(
              btnText: 'START EXPLORING',
              onClick: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, MAIN_ROUTE, (r) => false);
              },
            ),
          )
        ],
      ),
    );
  }
}
