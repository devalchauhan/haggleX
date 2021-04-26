import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/presantation/widgets/login_widgets.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';

class RegistrationPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final referralController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/back_button.png',
                        height: 35.0,
                        width: 45.0,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          color: kColorWhite,
                          border: Border.all(
                            color: kColorTextGolden,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create a new account',
                            style: kTextStyle.copyWith(
                                fontSize: 15.0, color: kColorBlack),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RegistrationTextField(
                            controller: emailController,
                            hintText: 'Email Address',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RegistrationTextField(
                            controller: passwordController,
                            hintText: 'Password (Min. 8 characters)',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RegistrationTextField(
                            controller: usernameController,
                            hintText: 'Create a username',
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kColorGray,
                                      border: Border.all(
                                          color: kColorBlack, width: 0.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('(+234)'),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: RegistrationTextField(
                                    controller: phoneNumberController,
                                    hintText: 'Enter your phone number',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RegistrationReferralTextField(
                            controller: referralController,
                            hintText: 'Referral code (optional)',
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'By signing, you agree to HaggleX terms and privacy policy.',
                            style: kRegistrationHintTextStyle.copyWith(
                              fontSize: 10.0,
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          RegistrationGradientButton(
                            onClick: () {
                              Navigator.pushNamed(context, VERIFICATION_ROUTE);
                            },
                            btnText: 'SIGN UP',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
