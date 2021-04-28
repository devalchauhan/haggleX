import 'package:flutter/material.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/presentation/pages/splash_page.dart';
import 'package:hagglex/feature/auth/presantation/pages/countries_page.dart';
import 'package:hagglex/feature/auth/presantation/pages/login_page.dart';
import 'package:hagglex/feature/auth/presantation/pages/registartion_page.dart';

import 'feature/auth/presantation/pages/complete_setup_page.dart';
import 'feature/auth/presantation/pages/verification_page.dart';
import 'feature/dashboard/presantation/pages/main_page.dart';

class AppRouter {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case REGISTRATION_ROUTE:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case VERIFICATION_ROUTE:
        final email = routeSettings.arguments;
        return MaterialPageRoute(
            builder: (_) => VerificationPage(
                  email: email,
                ));
      case COMPLETE_SETUP_ROUTE:
        return MaterialPageRoute(builder: (_) => CompleteSetupPage());
      case MAIN_ROUTE:
        return MaterialPageRoute(builder: (_) => MainPage());
      case COUNTRIES_ROUTE:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CountriesPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      default:
        return null;
    }
  }
}
