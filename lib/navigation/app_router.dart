import 'package:auto_route/auto_route.dart';
import 'package:firebase_costs/features/auth/login/auth_screen.dart';
import 'package:firebase_costs/features/auth/registration/registration_screen.dart';
import 'package:firebase_costs/features/dashboard/dashboard_screen.dart';
import 'package:firebase_costs/features/dashboard/widgets/add_transaction_dialog.dart';
import 'package:flutter/cupertino.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    // CustomRoute(
    //   initial: true,
    //   page: SplashScreen,
    //   durationInMilliseconds: 400,
    //   transitionsBuilder: TransitionsBuilders.fadeIn,
    // ),
    AutoRoute(
      initial: true,
      page: AuthScreen,
    ),
    AutoRoute(
      page: RegistrationScreen,
    ),
    AutoRoute(
      page: DashboardScreen,
    ),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter();
}
