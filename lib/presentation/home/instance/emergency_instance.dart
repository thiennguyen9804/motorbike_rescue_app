import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class EmergencyInstance {
  EmergencyInstance._privateConstructor();

  static final EmergencyInstance _instance =
      EmergencyInstance._privateConstructor();

  factory EmergencyInstance() {
    return _instance;
  }

  Widget emergencyDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error,
            color: AppTheme.bgDanger2nd,
            size: 50,
          ),
          const SizedBox(height: 10),
          const Text(
            'Có một vụ tai nạn gần chỗ bạn',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff323232),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Họ cần sự giúp đỡ của bạn',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff323232),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.bgDanger2nd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'TÔI SẼ TỚI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.close),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ],
    );
  }

  // Method to show the emergency dialog
  void showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: emergencyDialog,
    ).then(
      (value) {
        if (kDebugMode) {
          print('Emergency dialog closed');
        }
      },
    );
  }
}
