import 'package:bloc/bloc.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/domain/usecases/login.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login login;

  LoginCubit({this.login}) : super(LoginInitial());

  Future<void> callLogin(LoginParams loginParams) async {
    emit(LoginProcessing());
    final loginFailedOrSuccess = await login(loginParams);
    var error;
    loginFailedOrSuccess.fold(
      (l) {
        final failure = l as AuthFailure;
        emit(LoginError(error: failure.error));
      },
      (r) => emit(LoggedIn()),
    );
  }
}
