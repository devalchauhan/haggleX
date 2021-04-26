import 'package:flutter/material.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    @required String email,
    @required String phoneNumber,
    @required String displayName,
    @required String userId,
    @required String token,
  }) : super(
            email: email,
            phoneNumber: phoneNumber,
            displayName: displayName,
            userId: userId,
            token: token);

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'token': token,
    };
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    final data = json['action'];
    final user = data['user'];
    return AuthUserModel(
      email: user['email'],
      phoneNumber: user['phonenumber'],
      displayName: user['username'],
      userId: user['_id'],
      token: data['token']
    );
  }
}
