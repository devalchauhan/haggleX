import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/error/exceptions/exceptions.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/login_user.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/entities/verify_user.dart';

abstract class AuthRemoteDataSource {
  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> login(LoginUser loginUser);

  /// Throws a [AuthException] for all error codes.
  Future<AuthUserModel> register(RegisterUser registerUser);

  /// Throws a [DataBaseException] for all error codes.
  Future<AuthUserModel> verify(VerifyUser verifyUser);

  Future<bool> resendVerificationCode(VerifyUser verifyUser);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink(
      URL,
    ),
  );

  @override
  Future<AuthUserModel> login(LoginUser loginUser) async {
    try {
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
      AuthUserModel authUserModel = AuthUserModel.fromJson(result.data);

      return Future.value(authUserModel);
    } catch (e) {
      throw AuthException(error: e.error);
    }
  }

  String _token = '';

  Future<void> sendVerificationCode(String email, String token) async {
    const String sendVerification = r'''
      query SendCode($data: RedisVerifyCodeInput!) {
         getRedisVerifyCode(data:$data)
      }
      ''';
    final variable = {
      "data": {
        "email": email,
      }
    };
    _token = token;
    QueryOptions(
      document: gql(sendVerification),
      variables: variable,
    );
  }

  Future<bool> resendVerificationCode(VerifyUser verifyUser) async {
    try {
      const String resendVerification = r'''
      query ResendCode($data: EmailInput!) {
         resendVerificationCode(data:$data)
      }
      ''';
      final variable = {
        "data": {
          "email": verifyUser.email,
        }
      };
      final QueryOptions options = QueryOptions(
        document: gql(resendVerification),
        variables: variable,
      );
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        final gqlErrors = result.exception.graphqlErrors;
        if (gqlErrors != null) if (gqlErrors.length > 0)
          throw AuthException(error: gqlErrors.first.message);
        throw AuthException(error: 'Something went wrong');
      }
      bool resend = result.data['resendVerificationCode'];
      return Future.value(resend);
    } catch (e) {
      throw AuthException(error: e.error);
    }
  }

  @override
  Future<AuthUserModel> register(RegisterUser registerUser) async {
    try {
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
        final gqlErrors = result.exception.graphqlErrors;
        if (gqlErrors != null) if (gqlErrors.length > 0)
          throw AuthException(error: gqlErrors.first.message);
        throw AuthException(error: 'Something went wrong');
      }
      AuthUserModel authUserModel = AuthUserModel.fromJson(result.data);
      sendVerificationCode(authUserModel.email, authUserModel.token);
      return Future.value(authUserModel);
    } catch (e) {
      throw AuthException(error: e.error);
    }
  }

  @override
  Future<AuthUserModel> verify(VerifyUser verifyUser) async {
    try {
      const String verify = r'''
        mutation Verify($data: VerifyUserInput!) {
          action: verifyUser(data: $data) {
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

      final variable = {
        "data": {
          "code": int.parse(verifyUser.code),
        }
      };

      final _httpLink = HttpLink(
        URL,
      );

      final _authLink = AuthLink(
        getToken: () async => 'Bearer $_token',
      );

      Link _link = _authLink.concat(_httpLink);

      final GraphQLClient client = GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: _link,
      );

      final MutationOptions options = MutationOptions(
        document: gql(verify),
        variables: variable,
      );
      QueryResult result = await client.mutate(options);

      if (result.hasException) {
        final gqlErrors = result.exception.graphqlErrors;
        if (gqlErrors != null) if (gqlErrors.length > 0)
          throw AuthException(error: gqlErrors.first.message);
        throw AuthException(error: 'Something went wrong');
      }

      return Future.value(AuthUserModel.fromJson(result.data));
    } catch (e) {
      throw AuthException(error: e.error);
    }
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
