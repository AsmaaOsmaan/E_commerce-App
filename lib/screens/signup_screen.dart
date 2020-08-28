
import 'package:e_commerc/provider/progras_hud.dart';
import 'package:e_commerc/services/auth.dart';
import 'package:e_commerc/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../constans.dart';
import 'user/home.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static String id='SignupScreen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _name ,_email,_password;
  final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
  final auth=Auth();
  @override
  Widget build(BuildContext context){
    // final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
    double heigh=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KmainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<prograssHud>(context).isLoading,
        child: Form(
          key:_globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/icons/iconbuy.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Buy it',
                          style: TextStyle(
                              fontFamily:'Pacifico',
                              fontSize: 25
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: heigh*0.1,
              ),
              new CustomTextField( onClick: (value){
                _name=value;
              },hint: 'Enter your Name',icon: Icons.perm_identity,),
              SizedBox(
                height: heigh*0.02,
              ),
              new CustomTextField(

                onClick: (value){
                  _email=value;
                },
                hint: 'Enter your Email',icon: Icons.email,),
              SizedBox(
                height: heigh*0.02,
              ),
              new CustomTextField(
                onClick: (value){
                _password=value;
              }
              ,hint: 'Enter your password',icon: Icons.lock,),
              SizedBox(
                height: heigh*0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: Builder(

                builder:(context)=>FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    onPressed: ()async{
                      final modelHud=Provider.of<prograssHud>(context,listen: false);
                      modelHud.changhisLoading(true);
                      if(_globalKey.currentState.validate()){
                        _globalKey.currentState.save();
                        try{
                          final authResult= await  auth.SignUp(_email.trim(), _password.trim());
                          modelHud.changhisLoading(false);

                          Navigator.pushNamed(context, Home.id);
                        }
                     on PlatformException   catch(e){
                       modelHud.changhisLoading(false);

                       Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              e.message
                            ),
                          ));
                        }


                      }
                      modelHud.changhisLoading(false);
                    },

                    color: Colors.black,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: heigh*0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Do have an accout?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),),

                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text('Login',
                      style: TextStyle(

                          fontSize: 16
                      ),),
                  ),
                ],
              )


            ],

          ),
        ),
      ),
    );
  }
}
