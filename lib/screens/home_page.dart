import 'package:dgtera/widget/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipPath(
            child: Container(color: Colors.grey[100],height: 400,width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 87,),
                CircleAvatar(
                  maxRadius: 70,
                  backgroundColor: Colors.grey[300],
                  child: Icon(FontAwesomeIcons.userAlt,size: 40,color: Colors.white,),
                ),
                SizedBox(height: 30,),
                Text("User Name",style: TextStyle(color: Colors.grey[600],fontSize: 30,fontWeight: FontWeight.bold),),
                Text("title",style: TextStyle(color: Colors.grey[600],fontSize: 24),),
              ],
            ),),
            clipper: CustomClipPath(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: (){},
                child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(FontAwesomeIcons.clock,size: 60,color: Colors.orange,),
                  Spacer(),
                  Text("Check In",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold,fontSize: 24),),
                  Spacer(),
                ],
            ),
              ),),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(FontAwesomeIcons.clock,size: 60,color: Colors.orange,),
                    Spacer(),
                    Text("Check Out",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold,fontSize: 24),),
                    Spacer(),
                  ],
                ),
              ),),
          ),
        ],
      ),
    );
  }
}