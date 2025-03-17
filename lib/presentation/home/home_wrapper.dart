import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/user_emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/user_emergency_instance.dart';
import 'package:motorbike_rescue_app/presentation/home/page/device_screen.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/emergency_instance.dart';
import 'package:motorbike_rescue_app/presentation/home/page/map_screen.dart';

final screens = [
  MapScreen(),
  const DeviceScreen(),
];

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _selectedIndex = 0;
  final emergencyInstance = EmergencyInstance();
  final userEmgInstance = UserEmergencyInstance();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget listenerWidget(BuildContext context, Widget child) {
    return Builder(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<EmergencyCubit>(
              create: (context) => EmergencyCubit()..listenForEmergency(),
            ),
            BlocProvider<UserEmergencyCubit>(
              create: (context) =>
                  UserEmergencyCubit()..listenForUserEmergency(),
            ),
          ],
          child: BlocListener<EmergencyCubit, EmergencyState>(
            listener: (context, state) {
              switch (state) {
                case EmergencyHappened():
                  emergencyInstance.showEmergencyDialog(context);
                  break;
                default:
              }
            },
            child: BlocListener<UserEmergencyCubit, UserEmergencyState>(
                listener: (context, state) {
                  switch (state) {
                    case UserEmergencyConfirm():
                      userEmgInstance.showEmergencyBottomSheet(context, 30);
                      break;
                    default:
                  }
                },
                child: child),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.history),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 0 ? Icons.map : Icons.map_outlined),
            label: 'Bản đồ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 1 ? Icons.comment : Icons.comment_outlined),
            label: 'Thiết bị',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.textPos,
        onTap: _onItemTapped,
      ),
      body: listenerWidget(
        context,
        screens[_selectedIndex],
      ),
    );
  }
}
