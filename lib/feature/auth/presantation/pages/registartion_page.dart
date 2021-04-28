import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/presantation/cubit/registration_cubit.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if (state is Registered) {
            Navigator.pushReplacementNamed(context, VERIFICATION_ROUTE,
                arguments: state.authUserModel.email);
          } else if (state is RegistrationProcessing) {
            isLoading = true;
            CoolAlert.show(
              context: context,
              type: CoolAlertType.loading,
            );
          } else if (state is RegistrationError) {
            if (isLoading) {
              Navigator.pop(context);
              isLoading = false;
            }
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Registration",
              text: state.error,
            );
          }
        },
        child: Stack(
          children: [
            Background(),
            RegistrationBody(),
          ],
        ),
      ),
    );
  }
}
