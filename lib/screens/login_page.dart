import 'package:dgtera/persistence/api_provider.dart';
import 'package:dgtera/widget/custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../assets.dart';
import 'home_page.dart';

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
                        Text("Login",style: TextStyle(color: Colors.grey[700],fontSize: 20),),
                        SizedBox(height: 30,),
                        CircleAvatar(
                          maxRadius: 90,
                          backgroundColor: Colors.grey[300],
                          child: Icon(FontAwesomeIcons.userAlt,size: 60,color: Colors.grey[700],),
                        ),
                    SizedBox(height: height+20,),
                    buildTextFormField(hint: "URL.com",max: 32,type: TextInputType.url,customController: urlController),
                    SizedBox(height: height,),
                    buildTextFormField(hint: "Email",type: TextInputType.emailAddress,customController: emailController),
                    SizedBox(height: height,),
                    buildTextFormField(hint: "Password",isPassword: true,max: 32,type: TextInputType.text,customController: passwordController),
                    SizedBox(height: height+10,),
                     Row(
                       children: [
                         Expanded(flex: 5,child: RaisedButton(
                           color: Colors.orange,
                           onPressed: ()async{
                             if (_formKey.currentState.validate()) {
                               API().login(urlController.text.trim(), emailController.text.trim(), passwordController.text.trim());
                             await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                             }
                           },
                           child: Text("Login",style: TextStyle(color: Colors.white),),
                         )),
                         SizedBox(width: 20,),
                         Expanded(flex: 2,child: RaisedButton(
                           child: Icon(Icons.fingerprint,color: Colors.white,),
                           onPressed: (){
                           },
                           color: Colors.orange,
                         )),
                       ],
                     ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/4,),
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
