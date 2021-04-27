import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/feature/auth/data/model/country.dart';
import 'package:hagglex/feature/auth/data/model/phone_number_detail.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/register.dart';
import 'package:hagglex/feature/auth/presantation/cubit/registration_cubit.dart';

class RegistrationTextField extends StatelessWidget {
  const RegistrationTextField({
    Key key,
    @required this.controller,
    this.hintText,
    this.textInputType,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      keyboardType: textInputType,
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
    this.textInputType,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      keyboardType: textInputType,
      cursorColor: kColorBlack,
      controller: controller,
      decoration: kInputDecorationRegistration.copyWith(
          hintText: hintText, hintStyle: kRegistrationReferralHintTextStyle),
      style: kTextStyle.copyWith(color: kColorBlack),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key key,
    @required this.controller,
    this.hintText,
    this.focusNode, this.onTextChange,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final Function onTextChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      cursorColor: kColorWhite,
      controller: controller,
      decoration: kInputDecorationSearch.copyWith(
        hintText: hintText,
        suffixIcon: Icon(
          Icons.search,
          color: kColorWhite,
        ),
      ),
      onChanged: onTextChange,
      style: kTextStyle,
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

class RegistrationBody extends StatefulWidget {
  @override
  _RegistrationBodyState createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final usernameController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final referralController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final userNameFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final referralFocusNode = FocusNode();
  Country country = Country(
      code: '234',
      flag: 'https://restcountries.eu/data/nga.svg',
      name: "Nigeria",
      currency: "NGN");

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
                      focusNode: emailFocusNode,
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: 'Email Address',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RegistrationTextField(
                      focusNode: passwordFocusNode,
                      textInputType: TextInputType.text,
                      controller: passwordController,
                      hintText: 'Password (Min. 8 characters)',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RegistrationTextField(
                      focusNode: userNameFocusNode,
                      textInputType: TextInputType.text,
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
                          child: InkWell(
                            onTap: () async {
                              // Navigator.of(context).push(_createRoute());
                              final result = await Navigator.pushNamed(
                                  context, COUNTRIES_ROUTE);
                              if (result is Country) {
                                setState(() {
                                  country = result;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kColorGray,
                                  border: Border.all(
                                      color: kColorBlack, width: 0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.network(
                                      country.flag,
                                      semanticsLabel: 'Country flag',
                                      /*placeholderBuilder: (BuildContext context) => Container(
                                    child: const CircularProgressIndicator()),*/
                                    ),
                                  ),
                                  Text(
                                    ' (+${country.code})',
                                    style: kTextStyle.copyWith(
                                        fontSize: 15, color: kColorBlack),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: RegistrationTextField(
                              focusNode: phoneNumberFocusNode,
                              textInputType: TextInputType.phone,
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
                      focusNode: referralFocusNode,
                      textInputType: TextInputType.text,
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
                        emailFocusNode.unfocus();
                        passwordFocusNode.unfocus();
                        userNameFocusNode.unfocus();
                        phoneNumberFocusNode.unfocus();
                        referralFocusNode.unfocus();
                        BlocProvider.of<RegistrationCubit>(context)
                            .callRegister(
                          RegisterParams(
                            registerUser: RegisterUser(
                              email: emailController.text,
                              password: passwordController.text,
                              username: usernameController.text,
                              phonenumber: phoneNumberController.text,
                              currency: country.currency,
                              country: country.name,
                              referralCode: referralController.text,
                              phoneNumberDetail: PhoneNumberDetail(
                                phoneNumber: phoneNumberController.text,
                                callingCode: country.code,
                                flag: country.flag,
                              ),
                            ),
                          ),
                        );
                        // Navigator.pushNamed(context, VERIFICATION_ROUTE);
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
    );
  }
}
