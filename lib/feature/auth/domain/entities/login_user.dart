import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginUser extends Equatable {
  final String email;
  final String password;
  LoginUser({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [
    email,
    password,
  ];
}
