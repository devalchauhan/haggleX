import 'package:bloc/bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/register.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final Register register;

  RegistrationCubit({this.register}) : super(RegistrationInitial());

  void callRegister(RegisterParams registerParams) async {
    RegisterUser registerUser =registerParams.registerUser;
    if (registerUser.email.isEmpty) {
      emit(RegistrationError(error: "Email is empty"));
      return;
    }else if(!RegExp(EMAIL_REGEX).hasMatch(registerUser.email)){
      emit(RegistrationError(error: "Email invalid"));
      return;
    }else if(registerUser.password.length<8){
      emit(RegistrationError(error: "Password must be 8 character long"));
      return;
    }else if(registerUser.username.isEmpty){
      emit(RegistrationError(error: "Username is empty"));
      return;
    }else if(registerUser.phonenumber.isEmpty){
      emit(RegistrationError(error: "Phone number is empty"));
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
