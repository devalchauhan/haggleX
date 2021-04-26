

import 'package:dartz/dartz.dart';
import 'package:hagglex/core/error/exceptions/exceptions.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/auth_user.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
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
      final AuthUserModel _currentUser = await authRemoteDataSource.login(loginUser);
      return Right(_currentUser);
    } catch(e) {
      return Left(AuthFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthUser>> verify() {
    // TODO: implement verify
    throw UnimplementedError();
  }

}