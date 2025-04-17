import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/emergency_instance.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key, required this.onLogout});
  final VoidCallback onLogout;
  final emergencyInstance = EmergencyInstance();

  void logout() {
    emergencyInstance.removeOverlay();
    onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: logout,
        child: Text('Logout'),
      ),
    );
  }
}
