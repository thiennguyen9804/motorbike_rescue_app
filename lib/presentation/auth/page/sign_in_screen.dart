import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Đăng nhập",
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
            text: "Chưa có tài khoản ",
            children: [
              TextSpan(
                text: 'Đăng ký',
                style: TextStyle(
                  color: AppTheme.textPos,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/sign-up');
                  },
              ),
            ],
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Email",
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Mật khẩu",
          ),
        ),
        SizedBox(height: 30),
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
            Expanded(
              child: Text('Nhớ mật khẩu'),
            ),
            GestureDetector(
              child: Text('Quên mật khẩu'),
              onTap: () {
                Navigator.pushNamed(context, '/forget-password');
              },
            ),
          ],
        ),
        SizedBox(height: 50),
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
            onPressed: () {},
            child: Text(
              'Đăng nhập',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
