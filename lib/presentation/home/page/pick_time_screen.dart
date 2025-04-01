import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/data/picked_times.dart';
import 'package:motorbike_rescue_app/presentation/home/page/widget/search_bar_widget.dart';

class PickTimeScreen extends StatefulWidget {
  const PickTimeScreen({super.key});

  @override
  PickTimeScreenState createState() => PickTimeScreenState();
}

class PickTimeScreenState extends State<PickTimeScreen> {
  DateTime selectedFromDateTime = DateTime(2025, 2, 22, 14, 30);

  DateTime selectedToDateTime = DateTime.now();
  final pickerTheme = ThemeData.light().copyWith(
    primaryColor: Colors.green,
    colorScheme: ColorScheme.light(primary: Colors.green),
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
  );

  Future<void> _selectDateTime(BuildContext context, bool isFrom) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: const Locale('vi', ''),
      initialDate: isFrom ? selectedFromDateTime : selectedToDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: pickerTheme,
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          isFrom ? selectedFromDateTime : selectedToDateTime,
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: pickerTheme,
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        setState(() {
          if (isFrom) {
            selectedFromDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          } else {
            selectedToDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          }
        });
      }
    }
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('EEEE, dd/MM/yyyy - HH:mm', 'vi');
    return dateFormat.format(dateTime);
  }

  Future searchRoute() async {
    PickedTimes(from: selectedFromDateTime, to: selectedToDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: SearchBarWidget(
                      selectedFromDateTime: selectedFromDateTime,
                      selectedToDateTime: selectedToDateTime,
                      onSearch: () {},
                      onSelectDateTime: (bool isFrom) =>
                          _selectDateTime(context, isFrom),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: searchRoute,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text('Thứ Bảy, 22/02/2025 - 14:30'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Xem thêm các mốc thời gian khác',
                style: TextStyle(
                  color: AppTheme.textPos,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateTimePicker(
    BuildContext context,
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

    return GestureDetector(
      onTap: () => _selectDateTime(context, isFrom),
      child: AbsorbPointer(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffB5B5B5),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              isNow
                  ? 'Thời điểm hiện tại'
                  : formatDateTime(selectedDateTime ?? DateTime.now()),
              style: TextStyle(
                color: isNow ? Colors.green : (textColor ?? Color(0xff444444)),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
