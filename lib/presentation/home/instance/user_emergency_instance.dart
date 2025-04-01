import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/bottom_sheet/is_danger_bottom_sheet.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/bottom_sheet/is_safe_bottom_sheet.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/bottom_sheet/safe_confirm_bottom_sheet.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/floating_noti/need_confirm_noti.dart';
import 'package:motorbike_rescue_app/presentation/home/helper_object/timer_helper.dart';

class UserEmergencyInstance {
  UserEmergencyInstance._privateConstructor();
  TimerHelper? _timerInstance;
  OverlayEntry? _overlayEntry;
  static final UserEmergencyInstance _instance =
      UserEmergencyInstance._privateConstructor();

  factory UserEmergencyInstance() {
    return _instance;
  }

  void setTimer(TimerHelper ts) {
    _timerInstance = ts;
  }

  void startTimer() {
    _timerInstance!.startTimer(30);
  }

  void removeTimer() {
    _timerInstance = null;
  }

  void showEmergencyBottomSheet(BuildContext context, int duration) {
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
          timerInstance: _timerInstance!,
          onSafe: () {
            // Navigator.of(context).pop('safe');
            showIsSafeBtmSheet(context);
            _timerInstance!.stopTimer();
          },
          onDanger: () {
            // Navigator.of(context).pop('danger');
            showIsDangerBtmSheet(context);
            _timerInstance!.stopTimer();
          },
        );
      },
    ).then((value) {
      print('UserEmergencyInstance value: $value');
      if (value == null) {
        _showFloatingNotification(context, duration);
      }
    });
  }

  void _showFloatingNotification(BuildContext context, int duration) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => NeedConfirmNoti(
        onTap: () {
          removeFloatingNotification();
          showEmergencyBottomSheet(context, duration);
        },
        duration: duration,
        sharedTimer: _timerInstance!,
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void removeFloatingNotification() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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
