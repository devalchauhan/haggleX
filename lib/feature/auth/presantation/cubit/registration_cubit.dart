import 'package:bloc/bloc.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/domain/usecases/register.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final Register register;

  RegistrationCubit({this.register}) : super(RegistrationInitial());

  void callRegister(RegisterParams registerParams) async {
    if (registerParams.registerUser.email.isEmpty) {
      emit(RegistrationError(error: "Email is empty"));
      return;
    }
    emit(RegistrationProcessing());
    final registerFailedOrSuccess = await register(registerParams);
    registerFailedOrSuccess.fold(
      (l) {
        final failure = l as AuthFailure;
        emit(RegistrationError(error: failure.error));
      },
      (r) => emit(Registered()),
    );
  }
}
