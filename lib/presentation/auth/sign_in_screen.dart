import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/auth/auth_wrapper.dart';

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
            Text('Quên mật khẩu'),
          ],
        ),
        SizedBox(height: 30),
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
