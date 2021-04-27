class PhoneNumberDetail {
  final String phoneNumber;
  final String callingCode;
  final String flag;

  PhoneNumberDetail({this.phoneNumber, this.callingCode, this.flag});

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'callingCode': callingCode,
      'flag': flag,
    };
  }
}
