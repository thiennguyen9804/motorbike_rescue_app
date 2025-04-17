import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/instruction_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/user_emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/helper_object/timer_helper.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/mock/mock_route_instruction_controller.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/route_instruction_controller.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/user_emergency_instance.dart';
import 'package:motorbike_rescue_app/presentation/home/page/device_screen.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/emergency_instance.dart';
import 'package:motorbike_rescue_app/presentation/home/page/map_screen/map_screen.dart';
import 'package:motorbike_rescue_app/presentation/home/page/user_screen/user_screen.dart';

class HomeWrapper extends StatefulWidget {
  HomeWrapper({super.key, required this.onLogout}) {
    screens = [
      MapScreen(),
      const DeviceScreen(),
      UserScreen(onLogout: onLogout)
    ];
  }
  final VoidCallback onLogout;
  late List<Widget> screens;

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
                create: (context) => UserEmergencyCubit()
                // ..listenForUserEmergency(),
                ),
          ],
          child: BlocListener<EmergencyCubit, EmergencyState>(
            listener: (context, state) async {
              switch (state) {
                case EmergencyHappened(:final emergencyPoint):
                  emergencyInstance.showEmergencyDialog(context);
                  // emergencyInstance.showFloatingNotification(context);
                  break;
                case RouteFetched(:final polylinePoints, :final instructions):
                  emergencyInstance.showFloatingNotification(
                    context,
                    instructions,
                  );

                  // final _routeInstructionController =
                  //     RouteInstructionController(
                  //   instructions: instructions,
                  //   onUpdate: (updatedInstructions) {
                  //     emergencyInstance.updateInstructions(
                  //       updatedInstructions,
                  //       0,

                  //     );
                  //   },
                  // );

                  final controller = MockRouteInstructionController(
                    instructions: instructions,
                    onUpdate: (updatedInstructions) {
                      emergencyInstance.updateInstructions(
                        context,
                        instructions,
                        0,
                      );
                    },
                    mockPath: [
                      LatLng(10.885482, 106.782355),
                      LatLng(10.88527298706903, 106.78245245582151),
                      LatLng(10.884315580218399, 106.7832792493275),
                      LatLng(10.883083559557262, 106.78390498997832),
                      LatLng(10.881802533744107, 106.78280277893913),
                      LatLng(10.881403330205401, 106.78319886842198),
                      // ...
                    ],
                    mockInterval: Duration(seconds: 1),
                  );

                default:
              }
            },
            child: BlocListener<UserEmergencyCubit, UserEmergencyState>(
              listener: (context, state) {
                switch (state) {
                  case UserEmergencyConfirm():
                    final timerInstance = TimerHelper();
                    userEmgInstance.setTimer(timerInstance);
                    userEmgInstance.startTimer();
                    userEmgInstance.showEmergencyBottomSheet(context, 30);
                    break;
                  default:
                }
              },
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? Icons.account_circle
                : Icons.account_circle_outlined),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.textPos,
        onTap: _onItemTapped,
      ),
      body: listenerWidget(
        context,
        widget.screens[_selectedIndex],
      ),
    );
  }
}
