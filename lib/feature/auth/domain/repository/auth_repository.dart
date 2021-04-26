
import 'package:dartz/dartz.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';

abstract class AuthRepository{
  Future<Either<Failure, AuthUser>> getCurrentUser();
  Future<Either<Failure, AuthUser>> login(LoginUser loginUser);
  Future<Either<Failure, AuthUser>> register();
  Future<Either<Failure, AuthUser>> verify();
}