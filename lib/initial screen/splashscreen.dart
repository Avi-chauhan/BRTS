import 'package:brts/data.dart';
import 'package:flutter/material.dart';

class Screensplash extends StatefulWidget {
  @override
  _ScreensplashState createState() => _ScreensplashState();
}

class _ScreensplashState extends State<Screensplash> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Data.start));
    });

    return Container(
      color: Colors.white,
      child: Image.asset('images/splash.png', fit: BoxFit.fitHeight),
    );
  }
}
