import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fridsch_app/screens/household/household_screen.dart';
import 'package:fridsch_app/screens/login/login_screen.dart';
import 'package:fridsch_app/screens/register/register_screen.dart';
import 'package:fridsch_app/screens/start/start_loading_screen.dart';
import 'package:fridsch_app/screens/welcome/welcome_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fridsch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/household': (context) => const HouseholdScreen(),
        '/load': (context) => const LoadingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}
