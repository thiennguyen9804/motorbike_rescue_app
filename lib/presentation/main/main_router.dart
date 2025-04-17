import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/data/dto/tokens.dart';
import 'package:motorbike_rescue_app/data/repository/auth_repository.dart';
import 'package:motorbike_rescue_app/exception/no_tokens_exceptions.dart';
import 'package:motorbike_rescue_app/presentation/auth/auth_wrapper.dart';
import 'package:motorbike_rescue_app/presentation/home/home_wrapper.dart';
import 'package:motorbike_rescue_app/sl.dart';

class MainRouter extends StatefulWidget {
  const MainRouter({super.key});

  @override
  State<MainRouter> createState() => _MainRouterState();
}

class _MainRouterState extends State<MainRouter> {
  final ValueNotifier<bool?> isLoggedInNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final tokens = sl<AuthRepository>().getTokens();
      final now = DateTime.now().millisecondsSinceEpoch;
      if (tokens.tokenExpires > now) {
        isLoggedInNotifier.value = true;
      } else {
        await sl<AuthRepository>().refreshTokens(tokens);
        isLoggedInNotifier.value = true;
      }
    } on NoTokensExceptions {
      isLoggedInNotifier.value = false;
    }
  }

  void login() {
    isLoggedInNotifier.value = true;
  }

  void handleLogout() {
    isLoggedInNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: isLoggedInNotifier,
      builder: (context, isLoggedIn, _) {
        if (isLoggedIn == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return isLoggedIn
            ? HomeWrapper(onLogout: handleLogout)
            : AuthWrapper(onLoginSuccess: login);
      },
    );
  }
}
