import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hagglex/constants/string.dart';
import 'package:hagglex/constants/text_style.dart';
import 'package:hagglex/core/presentation/widget/background.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Background(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/hagglex_logo.png',
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'HaggleX',
                    style: kTextStyle.copyWith(fontSize: 26.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void startTime() async{
    var duration = new Duration(seconds: 3);
    Timer(duration, route);
  }

  void route() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }
}
