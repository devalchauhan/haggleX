import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/feature/auth/presantation/cubit/login_cubit.dart';
import 'package:hagglex/router.dart';

import 'constants/appMainColor.dart';
import 'injenction_container.dart' as di;
import 'injenction_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => sl<LoginCubit>()),
    ],
    child: HagglexApp(
      router: AppRouter(),
    ),
  ));
}

class HagglexApp extends StatelessWidget {
  final AppRouter router;

  const HagglexApp({Key key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppMainMaterialColor().colorCustom,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
