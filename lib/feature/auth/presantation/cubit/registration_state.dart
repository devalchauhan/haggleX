part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}
class RegistrationProcessing extends RegistrationState {}
class Registered extends RegistrationState {
  final AuthUserModel authUserModel;

  Registered({this.authUserModel});
}
class RegistrationError extends RegistrationState {
  final String error;

  RegistrationError({this.error});
}
