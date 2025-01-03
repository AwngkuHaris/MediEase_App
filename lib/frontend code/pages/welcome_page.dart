import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediease_app/frontend%20code/pages/main_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToMainPage() {
    final user = FirebaseAuth.instance.currentUser;
    final bool isSignedIn = user != null;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(isSignedIn: isSignedIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9AD4CC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
          'assets/images/mediease_logo.png', 
          height: 80,
        ),
          Padding(
          padding: const EdgeInsets.all(40.0),
          child: Lottie.asset(
            'assets/animations/welcome.json', 
            controller: _controller,
            onLoaded: (composition) {
              // Set the duration of the AnimationController
              _controller.duration = composition.duration;
          
              // Play the animation
              _controller.forward().whenComplete(() => _navigateToMainPage());
            },
          ),
        ),],
      ),
    );
  }
}
