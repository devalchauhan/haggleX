import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/error/exceptions/exceptions.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';

abstract class AuthRemoteDataSource {
  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> getCurrentUser();

  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> login(LoginUser loginUser);

  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> register(RegisterUser registerUser);

  /// Throws a [DataBaseException] for all error codes.
  Future<AuthUserModel> verify();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink(
      URL,
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

      QueryResult result = await gqRequest(login, variable);
      if (result.hasException) {
        final gqlErrors = result.exception.graphqlErrors;
        if (gqlErrors != null) if (gqlErrors.length > 0)
          throw AuthException(error: gqlErrors.first.message);
        throw AuthException(error: 'Something went wrong');
      }
      // final repositories = result.data['action']['user']['username'];
      // print(repositories);
      AuthUserModel authUserModel = AuthUserModel.fromJson(result.data);
      sendVerificationCode(authUserModel.email, authUserModel.token);
      return Future.value(authUserModel);
    } catch (e) {
      throw AuthException(error: e.error);
    }
  }

  Future<void> sendVerificationCode(String email, String token) async {
    const String sendVerification = r'''
      query SendCode($data: RedisVerifyCodeInput) {
         getRedisVerifyCode(data:$data)
      }
      ''';
    final variable = {
      "data": {
        "email": email,
      }
    };

    final _httpLink = HttpLink(
      URL,
    );

    final _authLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );

    Link _link = _authLink.concat(_httpLink);

    final GraphQLClient client =
        GraphQLClient(cache: GraphQLCache(store: HiveStore()), link: _link);
    final QueryOptions options = QueryOptions(
      document: gql(sendVerification),
      variables: variable,
    );
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    }
    print(result.data);
  }

  @override
  Future<AuthUserModel> register(RegisterUser registerUser) async {
    try {
      print("Function call register");

      const String register = r'''
        mutation Register($data: CreateUserInput!) {
          action: register(data: $data) {
                user{
                  username
                  email
                  _id
                  phonenumber
                  phoneNumberDetails{
                      phoneNumber
                      callingCode
                      flag
                  }
                }
                token
              }
        }
      ''';

      final phoneNumberDetail = {
        "phoneNumber": registerUser.phoneNumberDetail.phoneNumber,
        "callingCode": registerUser.phoneNumberDetail.callingCode,
        "flag": registerUser.phoneNumberDetail.flag,
      };

      final variable = {
        "data": {
          "email": registerUser.email,
          "username": registerUser.username,
          "password": registerUser.password,
          "phonenumber": registerUser.phonenumber,
          "referralCode": registerUser.referralCode,
          "phoneNumberDetails": phoneNumberDetail,
          "country": registerUser.country,
          "currency": registerUser.currency,
        }
      };

      QueryResult result = await gqRequest(register, variable);
      if (result.hasException) {
        print(result.exception);
        final gqlErrors = result.exception.graphqlErrors;
        if (gqlErrors != null) if (gqlErrors.length > 0)
          throw AuthException(error: gqlErrors.first.message);
        throw AuthException(error: 'Something went wrong');
      }

      print(result.data);

      // return Future.value(AuthUserModel.fromJson(result.data));
    } catch (e) {
      throw AuthException(error: e.error);
    }
  }

  @override
  Future<AuthUserModel> verify() {
    // TODO: implement verify
    throw UnimplementedError();
  }

  Future<QueryResult> gqRequest(
      String query, Map<String, dynamic> variable) async {
    final MutationOptions options = MutationOptions(
      document: gql(query),
      variables: variable,
    );
    return await client.mutate(options);
  }
}
