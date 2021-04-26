import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/core/error/exceptions/exceptions.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';

abstract class AuthRemoteDataSource {
  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> getCurrentUser();

  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> login(LoginUser loginUser);

  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> register();

  /// Throws a [DataBaseException] for all error codes.
  Future<AuthUserModel> verify();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink(
      'https://hagglex-backend-staging.herokuapp.com/graphql',
    ),
  );

  @override
  Future<AuthUserModel> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<AuthUserModel> login(LoginUser loginUser) async {
    try {
      print("Function call");

      const String login = r'''
        mutation Login($data: LoginInput!) {
          action: login(data: $data) {
                user{
                  username
                  email
                  _id
                  phonenumber
                }
                token
              }
        }
      ''';

      final variable = {
        "data": {
          "input": loginUser.email,
          "password": loginUser.password,
        }
      };

      final MutationOptions options = MutationOptions(
        document: gql(login),
        variables: variable,
      );
      QueryResult result = await client.mutate(options);
      if (result.hasException) {
        final gqlErrors = result.exception.graphqlErrors;
        if (gqlErrors != null) if (gqlErrors.length > 0)
          throw AuthException(error: gqlErrors.first.message);
        throw AuthException(error: 'Something went wrong');
      }
      // final repositories = result.data['action']['user']['username'];
      // print(repositories);
      return Future.value(AuthUserModel.fromJson(result.data));
    } catch (e) {
      throw AuthException(error: e.error);
    }
  }

  @override
  Future<AuthUserModel> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<AuthUserModel> verify() {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
