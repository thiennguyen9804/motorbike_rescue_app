import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/auth/sign_in_screen.dart';
import 'package:motorbike_rescue_app/presentation/auth/sign_up_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({
    super.key,
  });

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isSignIn = false;
  final int _duration = 150;
  bool showScreen = false;

  void _onHorizontalDragEnd(DragEndDetails details) {
    bool newState = details.primaryVelocity! > 0;

    if (newState != isSignIn) {
      setState(() {
        showScreen = false; // Ẩn màn hình trước khi thay đổi
      });

      Future.delayed(Duration(milliseconds: _duration), () {
        setState(() {
          isSignIn = newState;
          showScreen = true; // Hiện màn hình sau khi container mở rộng
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.png'),
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    color: Color(0xC414AE5C),
                  ),
                ),
              ),
              Positioned(
                top: statusBarHeight + 40,
                child: SafeArea(
                  child: Text(
                    "BIKE RESCUE",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                width: constraints.maxWidth,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: AnimatedContainer(
                    padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    height: isSignIn
                        ? MediaQuery.of(context).size.height * 0.6
                        : MediaQuery.of(context).size.height * 0.7,
                    duration: Duration(milliseconds: _duration),
                    curve: Curves.linear,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: _duration),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: isSignIn ? SignInScreen() : SignUpScreen(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
