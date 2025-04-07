import 'package:flutter/material.dart';
import 'package:portfolio/screens/splash_screen.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solomon Ondula Portfolio',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SplashScreenWrapper(),
    );
  }
}
