import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("more",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: true,
        shadowColor: Colors.white,
      ),
      body: ListView.separated(itemBuilder: (context,index){
        return ListTile(
          onTap: (){},
          leading: Icon(Icons.location_on,color: Colors.orange,),
          title: Text("Time Sheet",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
          trailing: Icon(Icons.arrow_forward_ios),
        );
      }, separatorBuilder:(BuildContext context, int index) => Divider(), itemCount: 10),
    );
  }
}
