import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/auth/auth_wrapper.dart';
import 'package:motorbike_rescue_app/presentation/home/home_wrapper.dart';

class MainRouter extends StatefulWidget {
  const MainRouter({super.key});

  @override
  State<MainRouter> createState() => _MainRouterState();
}

class _MainRouterState extends State<MainRouter> {
  bool isLoggedIn = false;

  void login() {
    setState(() {
      isLoggedIn = true;
    });
  }

  void handleLogout() {
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? HomeWrapper(
            onLogout: handleLogout,
          )
        : AuthWrapper(
            onLoginSuccess: login,
          );
  }
}
