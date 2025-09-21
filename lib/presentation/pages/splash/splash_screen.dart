import 'package:flutter/material.dart';
import 'package:harry_potter_adilet/gen/assets.gen.dart';
import 'dart:async';
import 'dart:math' as math;
import '../../layout/main_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _startAnimations();
  }

  void _startAnimations() async {
    _logoController.repeat();

    await Future.delayed(const Duration(seconds: 1));
    _navigateToMain();
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainLayout(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          SafeArea(
            child: Center(
              child: AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (math.sin(_logoController.value * 2 * math.pi) * 0.1),
                    child: Assets.images.harryPotterLogoBlack.image(),
                  );
                },
              ),
            ),
          ),
    );
  }
}
