import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/presantation/cubit/verify_cubit.dart';
import 'package:hagglex/feature/auth/presantation/widgets/verification_widgets.dart';
import 'package:toast/toast.dart';

class VerificationPage extends StatelessWidget {
  final String email;
  final codeController = TextEditingController();

  VerificationPage({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VerifyCubit, VerifyState>(
        listener: (context, state) {
          if (state is Verified) {
            Navigator.pushNamed(context, COMPLETE_SETUP_ROUTE);
          } else if (state is VerifyError) {
            Toast.show(state.error, context,
                duration: 3,
                backgroundColor: Colors.red,
                gravity: Toast.BOTTOM);
          } else if(state is ResendSuccess){
            Toast.show("Verification code sent successfully", context,
                duration: 3,
                backgroundColor: Colors.green,
                gravity: Toast.BOTTOM);
          }
        },
        child: Stack(
          children: [
            Background(),
            VerificationBody(
              email: email,
            )
          ],
        ),
      ),
    );
  }
}
