import 'package:bloc/bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/domain/usecases/login.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

const String empty_email = 'Please enter email';
const String invalid_email = 'Please enter valid email';
const String empty_password = 'Please enter password';

class LoginCubit extends Cubit<LoginState> {
  final Login login;

  LoginCubit({this.login}) : super(LoginInitial());

  void callLogin(LoginParams loginParams) async {
    if (loginParams.loginUser.email.isEmpty) {
      emit(LoginError(error: empty_email));
      return;
    } else if (!RegExp(EMAIL_REGEX).hasMatch(loginParams.loginUser.email)) {
      emit(LoginError(error: invalid_email));
      return;
    } else if (loginParams.loginUser.password.isEmpty) {
      emit(LoginError(error: empty_password));
      return;
    }
    emit(LoginProcessing());
    final loginFailedOrSuccess = await login(loginParams);
    loginFailedOrSuccess.fold(
      (l) {
        final failure = l as AuthFailure;
        emit(LoginError(error: failure.error));
      },
      (r) => emit(LoggedIn()),
    );
  }
}
