import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class OtpVeriScreen extends StatelessWidget {
  const OtpVeriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nhập OTP",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPos,
          ),
        ),
        SizedBox(height: 10),
        OtpTextField(
          numberOfFields: 6,
          focusedBorderColor: AppTheme.bgPos,
          borderColor: AppTheme.bgPos,
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode) {}, // end onSubmit
        ),
        SizedBox(height: 20),
        Text.rich(
          style: TextStyle(
            fontSize: 18,
          ),
          TextSpan(
            text: "Vẫn chưa nhận được OTP? ",
            children: [
              TextSpan(
                text: 'Gửi lại',
                style: TextStyle(
                  color: AppTheme.textPos,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // resend OTP
                  },
              ),
            ],
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
            onPressed: () {},
            child: Text(
              'Xác nhận',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
