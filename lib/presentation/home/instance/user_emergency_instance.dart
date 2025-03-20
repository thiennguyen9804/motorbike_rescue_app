import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/bottom_sheet/is_danger_bottom_sheet.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/bottom_sheet/is_safe_bottom_sheet.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/bottom_sheet/safe_confirm_bottom_sheet.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/floating_noti/need_confirm_noti.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/timer_instance.dart';

class UserEmergencyInstance {
  UserEmergencyInstance._privateConstructor();

  static final UserEmergencyInstance _instance =
      UserEmergencyInstance._privateConstructor();

  factory UserEmergencyInstance() {
    return _instance;
  }

  final TimerInstance _timerInstance = TimerInstance();

  void showEmergencyBottomSheet(BuildContext context, int duration) {
    _timerInstance.startTimer(duration);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return SafeConfirmBottomSheet(
          duration: duration,
          timerInstance: _timerInstance,
          onSafe: () {
            Navigator.of(context).pop('safe');
            showIsSafeBtmSheet(context);
          },
          onDanger: () {
            Navigator.of(context).pop('danger');
            showIsDangerBtmSheet(context);
          },
        );
      },
    ).then((value) {
      // Logic to handle when the bottom sheet is dismissed by tapping outside
      if (value == null) {
        // Show floating notification
        _showFloatingNotification(context, duration);
      }
    });
  }

  void _showFloatingNotification(BuildContext context, int duration) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => NeedConfirmNoti(duration: duration),
    );

    overlay.insert(overlayEntry);
  }

  void showIsSafeBtmSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return const IsSafeBottomSheet();
      },
    );
  }

  void showIsDangerBtmSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return const IsDangerBottomSheet();
      },
    );
  }
}
