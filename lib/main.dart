import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/models/user.dart';
import 'package:sabzz_bazzar/screens/loading.dart';
import 'package:sabzz_bazzar/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Sabzz Bazzar',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Loading(),
      ),
    );
  }
}
