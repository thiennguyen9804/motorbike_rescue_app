import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/auth/page/forget_password_screen.dart';
import 'package:motorbike_rescue_app/presentation/auth/page/otp_veri_screen.dart';
import 'package:motorbike_rescue_app/presentation/auth/page/sign_in_screen.dart';
import 'package:motorbike_rescue_app/presentation/auth/page/sign_up_screen.dart';

class AuthNavigator extends StatefulWidget {
  final ValueNotifier<double> containerHeightNotifier;
  final VoidCallback onLoginSuccess;

  const AuthNavigator({
    super.key,
    required this.containerHeightNotifier,
    required this.onLoginSuccess,
  });

  @override
  State<AuthNavigator> createState() => _AuthNavigatorState();
}

class _AuthNavigatorState extends State<AuthNavigator> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _updateHeight(String route) {
    switch (route) {
      case '/sign-in':
        widget.containerHeightNotifier.value = 0.6;
        break;
      case '/sign-up':
        widget.containerHeightNotifier.value = 0.7;
        break;
      case '/forget-password':
        widget.containerHeightNotifier.value = 0.5;
        break;
      case '/otp-veri':
        widget.containerHeightNotifier.value = 0.5;
        break;
      default:
        widget.containerHeightNotifier.value = 0.6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/sign-in',
      onGenerateRoute: (settings) {
        _updateHeight(settings.name!);
        switch (settings.name) {
          case '/sign-in':
            return MaterialPageRoute(
              builder: (_) => SignInScreen(
                onLoginSuccess: widget.onLoginSuccess,
              ),
            );
          case '/sign-up':
            return MaterialPageRoute(builder: (_) => SignUpScreen());
          case '/forget-password':
            return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
          case '/otp-veri':
            return MaterialPageRoute(builder: (_) => OtpVeriScreen());
          default:
            return MaterialPageRoute(
              builder: (_) => SignInScreen(
                onLoginSuccess: widget.onLoginSuccess,
              ),
            );
        }
      },
    );
  }
}
