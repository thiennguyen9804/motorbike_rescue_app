import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quên mật khẩu",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPos,
          ),
        ),
        Text.rich(
          style: TextStyle(
            fontSize: 18,
          ),
          TextSpan(
            text: "Quay lại ",
            children: [
              TextSpan(
                text: 'Đăng nhập',
                style: TextStyle(
                  color: AppTheme.textPos,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Email/Số điện thoại",
          ),
        ),
        SizedBox(height: 60),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 64,
              ),
              backgroundColor: AppTheme.bgPos,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/otp-veri');
            },
            child: Text(
              'Gửi OTP',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
