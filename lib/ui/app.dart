import 'package:flutter/material.dart';
import 'package:schedule/ui/pages/home.dart';
import 'package:schedule/ui/pages/schedule.dart';
import 'package:schedule/ui/pages/settings.dart';
import 'package:schedule/ui/pages/subject/list.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int navigationIndex = 0;

  List<Widget> navigationPages = [
    const HomePage(),
    const SchedulePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: navigationPages[navigationIndex],
        appBar: AppBar(title: const Text('Hello, Ryan!'), actions: <Widget>[
          IconButton(
              onPressed: () => throw UnimplementedError(),
              icon: const Icon(Icons.notifications_none))
          // TODO: change when notification system is completed
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ClassListPage())),
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
