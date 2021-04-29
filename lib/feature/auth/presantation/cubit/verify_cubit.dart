import 'package:bloc/bloc.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/verify_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/resendCode.dart';
import 'package:hagglex/feature/auth/domain/usecases/verify.dart';
import 'package:meta/meta.dart';

part 'verify_state.dart';

const String empty_code = 'Please enter Code';

class VerifyCubit extends Cubit<VerifyState> {
  final Verify verify;
  final ResendCode resendCode;

  VerifyCubit({this.verify, this.resendCode}) : super(VerifyInitial());

  void callResendCode(VerifyParams verifyParams) async {
    emit(VerifyProcessing());
    final verifyFailedOrSuccess = await resendCode(verifyParams);
    verifyFailedOrSuccess.fold(
      (l) {
        final failure = l as AuthFailure;
        emit(VerifyError(error: failure.error));
      },
      (r) => emit(ResendSuccess()),
    );
  }

  void callVerify(VerifyParams verifyParams) async {
    VerifyUser verifyUser = verifyParams.verifyUser;
    if (verifyUser.code.isEmpty) {
      emit(VerifyError(error: empty_code));
      return;
    }
    emit(VerifyProcessing());
    final verifyFailedOrSuccess = await verify(verifyParams);
    verifyFailedOrSuccess.fold(
      (l) {
        final failure = l as AuthFailure;
        emit(VerifyError(error: failure.error));
      },
      (r) => emit(Verified(authUserModel: r)),
    );
  }
}
