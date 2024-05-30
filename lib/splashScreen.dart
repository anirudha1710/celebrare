import 'package:celebrare/imageUploadPage.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 1500),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ImageUploadScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left:0.0, top: 160.0, right:0.0, bottom: 0.0),
        child: Container(
          child: Image.asset(
            "asset/splash.png",
          ),
        ),
      )
    );
  }
}
