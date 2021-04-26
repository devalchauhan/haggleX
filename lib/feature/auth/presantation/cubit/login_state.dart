part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginProcessing extends LoginState {}
class LoggedIn extends LoginState {}
class LoginError extends LoginState {
  final String error;

  LoginError({this.error});
}
