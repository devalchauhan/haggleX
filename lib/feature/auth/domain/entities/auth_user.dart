import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AuthUser extends Equatable {
  final String email;
  final String phoneNumber;
  final String displayName;
  final String userId;
  final String token;
  AuthUser({
    @required this.email,
    @required this.phoneNumber,
    @required this.displayName,
    @required this.userId,
    @required this.token,
  });

  @override
  List<Object> get props => [
    email,
    phoneNumber,
    displayName,
    userId,
    token,
  ];
}
