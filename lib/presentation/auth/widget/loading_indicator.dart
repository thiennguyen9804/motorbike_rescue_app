import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3, // giảm độ dày nếu muốn
      ),
    );
  }
}
