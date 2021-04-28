import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/feature/auth/domain/entities/verify_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/verify.dart';
import 'package:hagglex/feature/auth/presantation/cubit/verify_cubit.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';

class VerificationBody extends StatelessWidget {
  final String email;
  final codeController = TextEditingController();

  VerificationBody({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
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
              Text(
                'Verify your account',
                style: kTextStyle.copyWith(
                  fontSize: 25.0,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/verify_check.png',
                      height: 60.0,
                      width: 60.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'We just sent a verification code to your email. Please enter the code',
                        textAlign: TextAlign.center,
                        style: kRegistrationHintTextStyle.copyWith(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    RegistrationTextField(
                      controller: codeController,
                      hintText: 'Verification code',
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    RegistrationGradientButton(
                      onClick: () {
                        BlocProvider.of<VerifyCubit>(context).callVerify(
                            VerifyParams(
                                verifyUser: VerifyUser(
                                    email: email, code: codeController.text)));
                      },
                      btnText: 'VERIFY ME',
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'This code will expire in 10 minutes',
                      textAlign: TextAlign.center,
                      style: kRegistrationHintTextStyle.copyWith(
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<VerifyCubit>(context).callResendCode(
                            VerifyParams(verifyUser: VerifyUser(email: email)));
                      },
                      child: Text(
                        'Resend Code',
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(
                          fontSize: 15.0,
                          color: kColorBlack,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
