import 'package:bloc/bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/register.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

const String empty_email = 'Please enter email';
const String invalid_email = 'Please enter valid email';
const String invalid_password = "Password must be 8 character long";
const String empty_username = "Username is empty";
const String empty_phonenumber = "Phone number is empty";

class RegistrationCubit extends Cubit<RegistrationState> {
  final Register register;

  RegistrationCubit({this.register}) : super(RegistrationInitial());

  void callRegister(RegisterParams registerParams) async {
    RegisterUser registerUser = registerParams.registerUser;
    if (registerUser.email.isEmpty) {
      emit(RegistrationError(error: empty_email));
      return;
    } else if (!RegExp(EMAIL_REGEX).hasMatch(registerUser.email)) {
      emit(RegistrationError(error: invalid_email));
      return;
    } else if (registerUser.password.length < 8) {
      emit(RegistrationError(error: invalid_password));
      return;
    } else if (registerUser.username.isEmpty) {
      emit(RegistrationError(error: empty_username));
      return;
    } else if (registerUser.phonenumber.isEmpty) {
      emit(RegistrationError(error: empty_phonenumber));
      return;
    }
    emit(RegistrationProcessing());
    final registerFailedOrSuccess = await register(registerParams);
    registerFailedOrSuccess.fold(
      (l) {
        final failure = l as AuthFailure;
        emit(RegistrationError(error: failure.error));
      },
      (r) => emit(Registered(authUserModel: r)),
    );
  }
}
