class Country {
  final String code;
  final String flag;
  final String name;
  final String currency;

  Country({this.name, this.currency, this.code, this.flag});

  factory Country.fromJson(dynamic json) {
    return Country(
        name: json['name'],
        flag: json['flag'],
        currency: json['currencyCode'],
        code: json['callingCode']);
  }
}
