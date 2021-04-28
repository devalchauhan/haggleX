import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/core/usecases/usecase.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/entities/verify_user.dart';
import 'package:hagglex/feature/auth/domain/repository/auth_repository.dart';

class Verify implements UseCase<AuthUser, VerifyParams> {
  final AuthRepository authRepository;

  Verify({@required this.authRepository});

  @override
  Future<Either<Failure, AuthUser>> call(
      VerifyParams verifyParams) async {
    return await authRepository.verify(verifyParams.verifyUser);
  }
}

class VerifyParams extends Equatable {
  final VerifyUser verifyUser;

  VerifyParams({@required this.verifyUser});

  @override
  List<Object> get props => [verifyUser];
}
