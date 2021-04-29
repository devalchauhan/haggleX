import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/presantation/cubit/registration_cubit.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';
import 'package:toast/toast.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if (state is Registered) {
            Navigator.pushNamed(context, VERIFICATION_ROUTE,
                arguments: state.authUserModel.email);
          } else if (state is RegistrationError) {
            Toast.show(state.error, context,
                duration: 3,
                backgroundColor: Colors.red,
                gravity: Toast.BOTTOM);
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
