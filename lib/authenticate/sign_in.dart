import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/widgets.dart';
import 'package:sabzz_bazzar/services/auth.dart';
import 'package:sabzz_bazzar/services/loader.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  bool loader = false;
  String gError = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return loader ? Loader() : Scaffold(
      body: Container(
        height: h,
        width: w,
        child: Column(
          children: [
            SizedBox(height: h*0.1000,),
            Container(
              height: h*0.25,
              child: Image.asset('assets/sabzz.png',fit: BoxFit.fill,),
            ),
            SizedBox(height: h*0.0488,),
            Container(
              height: h*0.2,
              child: Image.asset('assets/signin.gif',fit: BoxFit.fill,),
            ),
            GoogleSignInButton(
              splashColor: Colors.green[600],
              onPressed: () async {
                setState(() {
                  loader = true;
                });
                dynamic result = await _auth.signInWithGoogle();
                if (result == null){
                  setState(() {
                    gError = 'Could Not Sign In With Google';
                    loader = false;
                  });
                } else{

                }
              },
             // darkMode: true, // default: false
            ),
            Text(
              gError,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            SizedBox(height: h*0.0188,),
            Image(
              image: AssetImage('assets/green.jpg'),
              height: h*0.315,
              width: w,
            ),
          ],
        ),
      ),
    );
  }
}
