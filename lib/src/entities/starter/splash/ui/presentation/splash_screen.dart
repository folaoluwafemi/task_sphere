import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87.withBlue(255).withOpacity(0.2),
      body: const Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
