import 'package:flutter/material.dart';
import 'package:repel/user_screens/myprofile.dart';
import 'home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });

    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/repel-a3a4e.appspot.com/o/assets%2Frepellogo.png?alt=media&token=f7a0ffa1-eb7b-425e-85f6-830ef76b32e4'),
      ),
    );
  }
}
