import 'package:bloc/bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/domain/usecases/login.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login login;

  LoginCubit({this.login}) : super(LoginInitial());

  void callLogin(LoginParams loginParams) async {
    if (loginParams.loginUser.email.isEmpty) {
      emit(LoginError(error: 'Please enter email'));
    } else if (!RegExp(EMAIL_REGEX).hasMatch(loginParams.loginUser.email)) {
      emit(LoginError(error: 'Please enter valid email'));
    } else if (loginParams.loginUser.password.isEmpty) {
      emit(LoginError(error: 'Please enter password'));
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
