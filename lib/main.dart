import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_assignment/Provider/splash_provider.dart';
import 'package:todo_assignment/Provider/todo_provider.dart';
import 'package:todo_assignment/Screens/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()..getTasks()),
        ChangeNotifierProvider(create: (context) => SplashProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
