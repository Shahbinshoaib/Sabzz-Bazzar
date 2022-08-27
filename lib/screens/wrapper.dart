import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/authenticate/authenticate.dart';
import 'package:sabzz_bazzar/models/user.dart';
import 'package:sabzz_bazzar/screens/home.dart';
import 'package:sabzz_bazzar/services/database.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //return either Home
    if (user == null){
      return Authenticate();
    } else {
      return StreamProvider<List<Veg>>.value(
        value: DatabaseService(uid: user.uid, email: user.email).myCart,
          child: Home());
    }
  }
}
