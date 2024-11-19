import 'package:flutter/material.dart';
import 'package:todo_assignment/Screens/home_screen.dart';

class SplashProvider extends ChangeNotifier {
  final Duration _splashDuration = const Duration(seconds: 2);

  splash(BuildContext context) {
    Future.delayed(_splashDuration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );

      notifyListeners();
    });
  }
}
