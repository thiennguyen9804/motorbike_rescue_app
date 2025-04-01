import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/auth/widget/auth_navigator.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final ValueNotifier<double> _containerHeightNotifier = ValueNotifier(0.6);
  final int _duration = 150;

  @override
  void dispose() {
    _containerHeightNotifier.dispose();
    super.dispose();
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
                child: ValueListenableBuilder<double>(
                  valueListenable: _containerHeightNotifier,
                  builder: (context, heightFactor, child) {
                    return AnimatedContainer(
                      padding:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * heightFactor,
                      duration: Duration(milliseconds: _duration),
                      curve: Curves.linear,
                      child: AuthNavigator(
                        containerHeightNotifier: _containerHeightNotifier,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
