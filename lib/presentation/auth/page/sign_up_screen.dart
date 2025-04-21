import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:motorbike_rescue_app/presentation/auth/widget/loading_indicator.dart';
import 'package:motorbike_rescue_app/sl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mật khẩu không khớp")),
      );
      return;
    }

    // final dto = AuthEmailSignUpDto(
    //   email: _emailCtrl.text,
    //   phone: _phoneCtrl.text,
    //   password: _passwordCtrl.text,
    // );

    // context.read<AuthCubit>().execute(dto, sl<SignUpUseCase>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state) {
            case AuthSuccess():
              Navigator.pushReplacementNamed(context, '/sign-in');
            case AuthFailed():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            default:
              break;
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
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
                  TextSpan(
                    text: "Đã có tài khoản? ",
                    children: [
                      TextSpan(
                        text: 'Đăng nhập',
                        style: TextStyle(
                            color: AppTheme.textPos,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, '/sign-in'),
                      ),
                    ],
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _phoneCtrl,
                  decoration: InputDecoration(hintText: "Số điện thoại"),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Mật khẩu"),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Nhập mật khẩu' : null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _confirmPasswordCtrl,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Nhập lại mật khẩu"),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Nhập lại mật khẩu'
                      : null,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) =>
                          setState(() => _rememberMe = value ?? false),
                    ),
                    Expanded(child: Text('Nhớ mật khẩu')),
                    Text('Quên mật khẩu'),
                  ],
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 64),
                          backgroundColor: AppTheme.bgPos,
                        ),
                        onPressed: () => _onSubmit(context),
                        child: isLoading
                            ? LoadingIndicator()
                            : Text('Đăng ký', style: TextStyle(fontSize: 20)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
