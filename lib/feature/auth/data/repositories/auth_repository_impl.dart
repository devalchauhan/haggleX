import 'package:dartz/dartz.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/entities/verify_user.dart';
import 'package:hagglex/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({this.authRemoteDataSource});

  @override
  Future<Either<Failure, AuthUser>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthUser>> login(LoginUser loginUser) async {
    try {
      final AuthUserModel _currentUser =
          await authRemoteDataSource.login(loginUser);
      return Right(_currentUser);
    } catch (e) {
      return Left(AuthFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> register(RegisterUser registerUser) async {
    try {
      final AuthUserModel _currentUser =
          await authRemoteDataSource.register(registerUser);
      return Right(_currentUser);
    } catch (e) {
      return Left(AuthFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> verify(VerifyUser verifyUser) async {
    try {
      final AuthUserModel _currentUser =
          await authRemoteDataSource.verify(verifyUser);
      return Right(_currentUser);
    } catch (e) {
      return Left(AuthFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, bool>> resendCode(VerifyUser verifyUser) async {
    try {
      final bool resendCode =
          await authRemoteDataSource.resendVerificationCode(verifyUser);
      return Right(resendCode);
    } catch (e) {
      return Left(AuthFailure(error: e.error));
    }
  }
}
