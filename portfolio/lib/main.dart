import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/screens/homepage.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

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
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: MyHomePage(),
    );
  }
}
