import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/models/user.dart';
import 'package:sabzz_bazzar/screens/veg_List.dart';


class VegList extends StatefulWidget {
  @override
  _VegListState createState() => _VegListState();
}

class _VegListState extends State<VegList> {


  @override
  Widget build(BuildContext context) {

    final vegs = Provider.of<List<Veg>>(context) ?? [];


    final user = Provider.of<User>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: vegs.length,
      itemBuilder: (context, index){
        return VegList2(vegs: vegs[index],);
      },
    );
  }
}

