import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hagglex/feature/auth/data/model/phone_number_detail.dart';

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
