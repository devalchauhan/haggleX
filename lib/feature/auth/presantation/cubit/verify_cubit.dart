import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hagglex/core/error/failures/failure.dart';
import 'package:hagglex/feature/auth/data/model/auth_user_model.dart';
import 'package:hagglex/feature/auth/domain/entities/verify_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/verify.dart';
import 'package:meta/meta.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final Verify verify;

  VerifyCubit({this.verify}) : super(VerifyInitial());

  void callResendCode(VerifyParams verifyParams) async {}
  void callVerify(VerifyParams verifyParams) async {
    VerifyUser verifyUser = verifyParams.verifyUser;
    if (verifyUser.code.isEmpty) {
      emit(VerifyError(error: "Code is empty"));
      return;
    }
    emit(VerifyProcessing());

    /*Timer(Duration(seconds: 2), () {
      emit(Verified());
    });*/
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
