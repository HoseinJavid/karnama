import 'package:flutter/material.dart';
import 'package:karnama/l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:karnama/view/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/animation/splash/animation.json',
              controller: _animationController, onLoaded: (p0) {
            _animationController.duration = p0.duration;
            _animationController.forward();
          }, width: 500, height: 500, fit: BoxFit.contain),
          Text(
            AppLocalizations.of(context)!.textWelcome,
            style: const TextStyle(fontSize: 28),
          )
        ],
      )),
    );
  }
}
