import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/emergency_dialog.dart';

class EmergencyInstance {
  EmergencyInstance._privateConstructor();

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
}
