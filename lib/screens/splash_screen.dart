import 'package:flutter/material.dart';
import '../assets.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      // 5s over, navigate to a new page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Icon(Icons.account_circle,size: 150,),
            Text("Check-IN / Check-OUT",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),),
            Spacer(),
            Image.asset(assets["logoImage"],width: 150,height: 50,)
          ],
        ),
      ),
    );
  }
}
