import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/constants/color.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/core/presentation/widget/background.dart';
import 'package:hagglex/feature/auth/data/model/phone_number_detail.dart';
import 'package:hagglex/feature/auth/domain/entities/register_user.dart';
import 'package:hagglex/feature/auth/domain/usecases/register.dart';
import 'package:hagglex/feature/auth/presantation/cubit/registration_cubit.dart';
import 'package:hagglex/feature/auth/presantation/widgets/login_widgets.dart';
import 'package:hagglex/feature/auth/presantation/widgets/registration_widgets.dart';

import 'countries_page.dart';

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
          if(state is Registered){
            Navigator.pushReplacementNamed(context, VERIFICATION_ROUTE);
          }else if(state is RegistrationProcessing){
            CoolAlert.show(
              context: context,
              type: CoolAlertType.loading,
            );
          }else if(state is RegistrationError){
            Navigator.pop(context);
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
