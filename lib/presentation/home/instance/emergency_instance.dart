import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/instruction_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/data/instruction_ui.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/emergency_dialog.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/floating_noti/emergency_noti.dart';

class EmergencyInstance {
  EmergencyInstance._privateConstructor();
  OverlayEntry? _overlayEntry;
  static final EmergencyInstance _instance =
      EmergencyInstance._privateConstructor();

  factory EmergencyInstance() {
    return _instance;
  }

  void updateInstruction(
    BuildContext context,
    InstructionUi newInstruction
  ) {
    // print('newsInstruction: ${newInstructions[newIndex]}');
    context.read<InstructionCubit>().updateInstruction(newInstruction);
  }

  // Method to show the emergency dialog
  void showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EmergencyDialog();
      },
    ).then(
      (value) {
        if (kDebugMode) {
          print('Emergency dialog closed');
        }
      },
    );
  }

  void showFloatingNotification(
    BuildContext context,
    List<InstructionUi> instructions,
  ) {
    final overlay = Overlay.of(context);
    final instructionCubit = BlocProvider.of<InstructionCubit>(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => BlocProvider.value(
        value: instructionCubit, // 👈 Truyền lại cubit đang có
        child: EmergencyNoti(
          onTap: () {},
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (kDebugMode) {
      print("Overlay removed");
    }
  }
}
