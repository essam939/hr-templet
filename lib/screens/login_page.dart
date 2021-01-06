import 'package:dgtera/persistence/api_provider.dart';
import 'package:dgtera/screens/tabs_page.dart';
import 'package:dgtera/widget/custom.dart';
import 'package:flutter/material.dart';
import '../assets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController urlController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  double height=20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 32,left: 32,right: 32),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Login",style: TextStyle(color: Colors.grey[700],fontSize: 22,fontWeight: FontWeight.bold),),
                        SizedBox(height: 80,),
                    Image.asset(assets["logoAr"]),
                    SizedBox(height: height+20,),
                    buildTextFormField(hint: "URL.com",max: 32,type: TextInputType.url,customController: urlController),
                    SizedBox(height: height,),
                    buildTextFormField(hint: "Email",type: TextInputType.emailAddress,customController: emailController),
                    SizedBox(height: height,),
                    buildTextFormField(hint: "Password",isPassword: true,max: 32,type: TextInputType.text,customController: passwordController),
                    SizedBox(height: height+10,),
                     Row(
                       children: [
                         SizedBox(height: 50,width: MediaQuery.of(context).size.width/1.2,child: RaisedButton(
                           color: Colors.deepPurple,
                           onPressed: ()async{
                             if (!_formKey.currentState.validate()) {
                               API().login(urlController.text.trim(), emailController.text.trim(), passwordController.text.trim());
                             await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TapsPage()));
                             }
                           },
                           child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                         )),
                       ],
                     ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/3.5,),
                  Image.asset(assets["logoImage"],width: 150,height: 50,)
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }

}
