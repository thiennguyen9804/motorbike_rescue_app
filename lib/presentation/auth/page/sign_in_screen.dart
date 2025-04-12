import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/data/dto/auth_email_login_dto.dart';
import 'package:motorbike_rescue_app/domain/login_use_case.dart';
import 'package:motorbike_rescue_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/home_wrapper.dart';
import 'package:motorbike_rescue_app/sl.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthSuccess():
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeWrapper()),
              );
            default:
              break;
          }
        },
        child: Column(
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
              controller: emailCtrl,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Mật khẩu",
              ),
              controller: passwordCtrl,
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
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 64,
                      ),
                      backgroundColor: AppTheme.bgPos,
                    ),
                    onPressed: () {
                      if (isLoading) {
                        return;
                      }
                      final params = AuthEmailLoginDto(
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      );
                      context
                          .read<AuthCubit>()
                          .execute(params, sl<LoginUseCase>());
                    },
                    child: !isLoading
                        ? Text(
                            'Đăng nhập',
                            style: TextStyle(fontSize: 20),
                          )
                        : CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
