import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/core/usecases/usecase.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/repository/auth_repository.dart';

class Register implements UseCase<AuthUser, RegisterParams> {
  final AuthRepository authRepository;

  Register({@required this.authRepository});

  @override
  Future<Either<Failure, AuthUser>> call(
      RegisterParams registerParams) async {
    return await authRepository.register(registerParams.registerUser);
  }
}

class RegisterParams extends Equatable {
  final RegisterUser registerUser;

  RegisterParams({@required this.registerUser});

  @override
  List<Object> get props => [registerUser];
}
