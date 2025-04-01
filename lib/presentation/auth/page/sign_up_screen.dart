import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Đăng ký",
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
            text: "Đã có tài khoản? ",
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
        TextFormField(
          decoration: InputDecoration(
            hintText: "Email",
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Số điện thoại",
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Mật khẩu",
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Nhập lại mật khẩu",
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
              ), // Add padding
              backgroundColor:
                  AppTheme.bgPos, // Ensure the background color is set
            ),
            onPressed: () {},
            child: Text(
              'Đăng ký',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
