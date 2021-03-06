import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/core/usecases/usecase.dart';
import 'package:hagglex/feature/auth/domain/repository/auth_repository.dart';
import 'package:hagglex/feature/auth/domain/usecases/verify.dart';

class ResendCode implements UseCase<bool, VerifyParams> {
  final AuthRepository authRepository;

  ResendCode({@required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(VerifyParams verifyParams) async {
    return await authRepository.resendCode(verifyParams.verifyUser);
  }
}
