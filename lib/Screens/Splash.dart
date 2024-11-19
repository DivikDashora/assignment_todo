import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_assignment/Helpers/constants.dart';
import 'package:todo_assignment/Helpers/helper_widgets.dart';
import 'package:todo_assignment/Provider/splash_provider.dart';
import 'package:todo_assignment/Screens/home_screen.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SplashProvider>(context, listen: false);

    prov.splash(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: HelperWidgets.getScreenwidth(context) * 0.25,
            backgroundImage: AssetImage('assets/download.jpeg'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              "To Do",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Constants.baseColor),
            ),
          )
        ],
      ),
    ));
  }
}
