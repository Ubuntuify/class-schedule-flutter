import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schedule/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  static final ThemeData _defaultLightTheme = ThemeData(
    colorSchemeSeed: const Color.fromRGBO(8, 120, 48, 100),
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    textTheme: GoogleFonts.bricolageGrotesqueTextTheme(),
  );

  static final ThemeData _defaultDarkTheme = ThemeData(
      colorSchemeSeed: const Color.fromRGBO(8, 120, 48, 100),
      brightness: Brightness.dark,
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        },
      ),
      textTheme:
          GoogleFonts.bricolageGrotesqueTextTheme(ThemeData.dark().textTheme));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule App (WIP)',
      theme: _defaultLightTheme,
      darkTheme: _defaultDarkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const AppScaffold(),
    );
  }
}
