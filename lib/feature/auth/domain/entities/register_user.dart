import 'package:equatable/equatable.dart';
import 'package:hagglex/feature/auth/data/model/phone_number_detail.dart';

class RegisterUser extends Equatable {
  final String email;
  final String username;
  final String password;
  final String phonenumber;
  final String referralCode;
  final String country;
  final String currency;
  final PhoneNumberDetail phoneNumberDetail;

  RegisterUser({
    this.username,
    this.phonenumber,
    this.referralCode,
    this.country,
    this.currency,
    this.phoneNumberDetail,
    this.email,
    this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
        username,
        phonenumber,
        referralCode,
        phoneNumberDetail,
        country,
        currency
      ];
}
