import 'package:flutter/material.dart';
import 'package:portfolio/screens/portfolio_screen.dart';

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData(); // Simulating data loading
  }

  Future<void> _loadData() async {
    // Simulate some loading time
    await Future.delayed(const Duration(seconds: 5));

    // After loading data, update the state to switch to the HomeScreen
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const SplashScreen() : PortfolioScreen();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Add a background color (you can replace with your theme color)
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          // Positioned background decoration
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.purple.shade800],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceHeight * 0.45,
                  width: deviceWidth * 0.7,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('assets/images/solo.png'),
                  ),
                ),
                SizedBox(height: deviceHeight * 0.05),
                // Add a fading animation to the CircularProgressIndicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                  strokeWidth: 4,
                ),
                SizedBox(height: deviceHeight * 0.02),
                const Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
