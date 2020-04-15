import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Introduction Page - Instructions about the app",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
