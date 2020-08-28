import 'package:e_commerc/constans.dart';
import 'package:e_commerc/provider/admin_mode.dart';
import 'package:e_commerc/provider/progras_hud.dart';
import 'package:e_commerc/screens/admin/admin_home.dart';
import 'package:e_commerc/screens/user/home.dart';
import 'package:e_commerc/screens/signup_screen.dart';
import 'package:e_commerc/services/auth.dart';
import 'package:e_commerc/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  // final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  bool isAdmin = false;
  final adminPassword = 'Admin1234';
  final auth = Auth();
  bool KeepMeLogedIn = false;
  final GlobalKey<FormState> _gllobalKey = GlobalKey<FormState>();
  // static String id='LoginScreen';
  @override
  Widget build(BuildContext context) {
    double heigh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KmainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<prograssHud>(context).isLoading,
        child: Form(
          key: _gllobalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
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
                          style:
                              TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: heigh * 0.1,
              ),
              new CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your Email',
                icon: Icons.email,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Theme(
                      data:ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: KsecondryColor,
                        activeColor: KmainColor,
                        value: KeepMeLogedIn,
                        onChanged: (value) {
                          setState(() {
                            KeepMeLogedIn = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remember me ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              new CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: heigh * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      if(KeepMeLogedIn==true){
                        keepUserLoggedIn();
                      }
                      validate(context);
                    },
                    color: Colors.black,
                    child: Text(
                      'login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: heigh * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\`t have an accout?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeisAdmin(true);
                            },
                            child: Text('I am admin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        Provider.of<AdminMode>(context).isAdmin
                                            ? KmainColor
                                            : Colors.white)))),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeisAdmin(false);
                        },
                        child: Text('I am user',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context).isAdmin
                                    ? Colors.white
                                    : KmainColor)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) async {
    final ModelHud = Provider.of<prograssHud>(context, listen: false);
    ModelHud.changhisLoading(true);
    if (_gllobalKey.currentState.validate()) {
      _gllobalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await auth.SignIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            ModelHud.changhisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          ModelHud.changhisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong"),
          ));
        }
      } else {
        try {
          await auth.SignIn(_email, _password);
          Navigator.pushNamed(context, Home.id);
        } catch (e) {
          ModelHud.changhisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    ModelHud.changhisLoading(false);
  }

  void keepUserLoggedIn() async{

SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
sharedPreferences.setBool(KkeepMeLoggedIn, KeepMeLogedIn);

  }
}
