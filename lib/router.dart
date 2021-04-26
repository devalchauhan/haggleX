import 'package:flutter/material.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/core/presentation/pages/splash_page.dart';
import 'package:hagglex/feature/auth/presantation/pages/login_page.dart';
import 'package:hagglex/feature/auth/presantation/pages/registartion_page.dart';

import 'feature/auth/presantation/pages/complete_setup_page.dart';
import 'feature/auth/presantation/pages/verification_page.dart';
import 'feature/dashboard/presantation/dashboard_page.dart';

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
        return MaterialPageRoute(builder: (_) => VerificationPage());
      case COMPLETE_SETUP_ROUTE:
        return MaterialPageRoute(builder: (_) => CompleteSetupPage());
      case DASHBOARD_ROUTE:
        return MaterialPageRoute(builder: (_) => DashBoardPage());
      default:
        return null;
    }
  }
}
