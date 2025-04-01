import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
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

  void showFloatingNotification(BuildContext context) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => EmergencyNoti(
        onTap: () {},
      ),
    );

    overlay.insert(_overlayEntry!);
  }
}
