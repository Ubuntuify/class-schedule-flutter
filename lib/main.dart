import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schedule/ui/app.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    /***
     * Sets up edge-to-edge support on Android.
     */
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent));

    /***
     * Returns Material app with Material You activated.
     */
    return MaterialApp(
      title: 'Schedule App (WIP)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green, brightness: Brightness.light),
        brightness: Brightness.light,
        useMaterial3: true,
        textTheme: GoogleFonts.bricolageGrotesqueTextTheme(),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green, brightness: Brightness.dark),
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: GoogleFonts.bricolageGrotesqueTextTheme(),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const AppScaffold(),
    );
  }
}

extension Range on num {
  bool isBetween(num from, num to) {
    return from < this && this < to;
  }
}
