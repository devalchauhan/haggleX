import 'package:equatable/equatable.dart';

class VerifyUser extends Equatable {
  final String email;
  final String code;

  VerifyUser({this.email, this.code});
  @override
  List<Object> get props => [
        email,
        code,
      ];
}
