import 'package:flutter/material.dart';
import 'package:schedule/ui/schedule.dart';
import 'package:schedule/ui/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navigationIndex = 0;

  List<Widget> navigationPages = [
    const HomePage(),
    const SchedulePage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // PopScope is setup for predictive back gestures on Android
      canPop: true,
      child: Scaffold(
        body: navigationPages[navigationIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) =>
              setState(() => navigationIndex = index),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: 'Classes'),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings')
          ],
          selectedIndex: navigationIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
      ),
    );
  }
}
