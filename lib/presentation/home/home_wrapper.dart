import 'package:flutter/material.dart';
import 'package:motorbike_rescue_app/core/configs/theme/app_theme.dart';
import 'package:motorbike_rescue_app/presentation/home/page/device_screen.dart';
import 'package:motorbike_rescue_app/presentation/home/page/map_screen.dart';

final screens = [
  const MapScreen(),
  const DeviceScreen(),
];

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: screens[_selectedIndex],
    );
  }
}
