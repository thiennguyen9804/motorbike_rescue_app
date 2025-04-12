// emergency_noti.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/instruction_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class EmergencyNoti extends StatelessWidget {
  final VoidCallback onTap;

  const EmergencyNoti({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructionCubit, List<InstructionUi>>(
      builder: (context, instructions) {
        Widget content;

        if (instructions.isEmpty) {
          content = const Text("Đang tải chỉ dẫn...");
        } else {
          final instruction = instructions[0]; // Lấy chỉ dẫn đầu tiên
          content = Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppTheme.onDanger,
                size: 50,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${instruction.distance.toStringAsFixed(1)} m',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.onDanger,
                    ),
                  ),
                  Text(
                    instruction.text,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.onDanger,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          );
        }

        return Positioned(
          top: 30,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.icDanger,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: content,
              ),
            ),
          ),
        );
      },
    );
  }
}
