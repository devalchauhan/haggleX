part of 'verify_cubit.dart';

@immutable
abstract class VerifyState {}

class VerifyInitial extends VerifyState {}
class VerifyProcessing extends VerifyState {}
class Verified extends VerifyState {
  final AuthUserModel authUserModel;

  Verified({this.authUserModel});
}
class VerifyError extends VerifyState {
  final String error;

  VerifyError({this.error});
}
