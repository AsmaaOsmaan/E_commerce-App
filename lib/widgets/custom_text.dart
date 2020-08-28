import 'package:flutter/material.dart';

import '../constans.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  String _errorMessage(String str){
    switch(hint){
      case 'Enter your Name':return 'name is requierd';
      case 'Enter your Email':return 'Email is requierd';
      case 'Enter your password':return 'password is requierd';
    }
  }
  CustomTextField({@required this.hint,@required this.icon,@required this.onClick});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(

        validator: (value){
     if(value.isEmpty){
       return _errorMessage(hint);
       }
        return null;
        },
        onSaved: onClick,
        cursorColor: KmainColor,
        obscureText: hint=='Enter your password'?true:false ,

        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: KmainColor,

          ),
          filled: true,
          fillColor: KsecondryColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white
              )

          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white
              )

          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.white
              )

          ),
        ),
      ),
    );
  }
}