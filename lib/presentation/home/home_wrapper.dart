import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/core/constant/app_constant.dart';
import 'package:motorbike_rescue_app/core/mapper/position_x.dart';
import 'package:motorbike_rescue_app/presentation/home/command/user_is_emergency_command.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/instruction_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/cubit/user_emergency_cubit.dart';
import 'package:motorbike_rescue_app/presentation/home/helper_object/timer_helper.dart';
import 'package:motorbike_rescue_app/presentation/home/instance/mock/mock_emergency_cubit.dart';
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
  // final timerHelper = TimerHelper()
  //   ..onTimerDone = () {
  //     UserIsEmergencyCommand().execute();
  //   };
  final userEmgInstance = UserEmergencyInstance()
    ..onDanger = () {
      UserIsEmergencyCommand().execute();
    };

  RouteInstructionController? _routeController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _routeController?.dispose();
    super.dispose();
  }

  Widget listenerWidget(BuildContext context, Widget child) {
    return Builder(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<EmergencyCubit>(create: (context) => EmergencyCubit()
                // ..listenForEmergency(),
                ),
            BlocProvider<UserEmergencyCubit>(
              create: (context) =>
                  UserEmergencyCubit()..listenForUserEmergency(),
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
                  _routeController?.dispose();
                  // _routeController = MockRouteInstructionController(
                  //   instructions: instructions,
                  //   onUpdate: (updatedInstructions, currentIndex) {
                  //     emergencyInstance.updateInstruction(
                  //       context,
                  //       updatedInstructions[currentIndex]
                  //     );

                  //     print('MockRouteInstructionController ${instructions[currentIndex]}');
                  //     print(currentIndex);
                  //   },

                  //   mockPath: [
                  //     LatLng(10.8769684, 106.8093181), // điểm khởi đầu
                  //     LatLng(10.877553741121432, 106.80867429350808), // gần hết mốc đầu tiên
                  //     LatLng(10.877589958852385, 106.80861997877935), // qua mốc thứ hai
                  //     LatLng(10.877631444611527, 106.80864143644995), // trên mốc thứ hai tới mốc thứ 3
                  //     // ...
                  //   ],
                  //   mockInterval: Duration(seconds: 3),
                  // );

                  _routeController = RouteInstructionController(
                    instructions: state.instructions,
                    onUpdate: (updatedInstructions, currentIndex) {
                      emergencyInstance.updateInstruction(
                        context,
                        updatedInstructions[currentIndex],
                      );
                      print(
                          'MockRouteInstructionController ${instructions[currentIndex]}');
                      print(currentIndex);
                    },
                  );

                default:
              }
            },
            child: BlocListener<UserEmergencyCubit, UserEmergencyState>(
              listener: (context, state) {
                switch (state) {
                  case UserEmergencyConfirm():
                    final timerHelper = TimerHelper()..onTimerDone = () {
                      UserIsEmergencyCommand().execute();
                    };
                    userEmgInstance.setTimer(timerHelper);
                    userEmgInstance.startTimer();
                    userEmgInstance.showEmergencyBottomSheet(
                      context,
                      AppConstant.TIME_TO_CALL_FOR_HELP,
                    );
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
