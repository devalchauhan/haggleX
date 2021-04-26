import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/core/usecases/usecase.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/repository/auth_repository.dart';

class Login implements UseCase<AuthUser, LoginParams> {
  final AuthRepository authRepository;

  Login({@required this.authRepository});

  @override
  Future<Either<Failure, AuthUser>> call(
      LoginParams loginParams) async {
    return await authRepository.login(loginParams.loginUser);
  }
}

class LoginParams extends Equatable {
  final LoginUser loginUser;

  LoginParams({@required this.loginUser});

  @override
  List<Object> get props => [loginUser];
}
