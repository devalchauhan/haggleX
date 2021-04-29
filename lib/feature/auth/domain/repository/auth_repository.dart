import 'package:dartz/dartz.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/entities/verify_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> login(LoginUser loginUser);
  Future<Either<Failure, AuthUser>> register(RegisterUser registerUser);
  Future<Either<Failure, AuthUser>> verify(VerifyUser verifyUser);
  Future<Either<Failure, bool>> resendCode(VerifyUser verifyUser);
}
