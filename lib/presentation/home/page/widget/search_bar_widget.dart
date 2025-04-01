import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';

class SearchBarWidget extends StatelessWidget {
  final DateTime selectedFromDateTime;
  final DateTime selectedToDateTime;
  final VoidCallback onSearch;
  final Function(bool) onSelectDateTime;

  const SearchBarWidget({
    Key? key,
    required this.selectedFromDateTime,
    required this.selectedToDateTime,
    required this.onSearch,
    required this.onSelectDateTime,
  }) : super(key: key);

  String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('EEEE, dd/MM/yyyy - HH:mm', 'vi');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dateTimeRow(
          context,
          Icons.access_time,
          true,
          selectedFromDateTime,
          null,
        ),
        const SizedBox(height: 10),
        dateTimeRow(
          context,
          Icons.radio_button_checked,
          false,
          selectedToDateTime,
          AppTheme.textPos,
        ),
      ],
    );
  }

  Widget dateTimeRow(
    BuildContext context,
    IconData icon,
    bool isFrom,
    DateTime? selectedDateTime,
    Color? textColor,
  ) {
    bool isNow = selectedDateTime != null &&
        selectedDateTime.year == DateTime.now().year &&
        selectedDateTime.month == DateTime.now().month &&
        selectedDateTime.day == DateTime.now().day &&
        selectedDateTime.hour == DateTime.now().hour &&
        selectedDateTime.minute == DateTime.now().minute;

    return Row(
      children: [
        Icon(icon, color: isFrom ? Colors.grey : Colors.green),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => onSelectDateTime(isFrom),
            child: AbsorbPointer(
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffB5B5B5),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    isNow
                        ? 'Thời điểm hiện tại'
                        : formatDateTime(selectedDateTime ?? DateTime.now()),
                    style: TextStyle(
                      color: isNow
                          ? Colors.green
                          : (textColor ?? const Color(0xff444444)),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
