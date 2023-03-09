import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/list_restaurant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    beginSplash();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage("images/logo.jpg"),
          height: 150,
          width: 150,
        ),
      ),
    );
  }

  beginSplash() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return const RestaurantListScreen();
        }),
      );
    });
  }
}
