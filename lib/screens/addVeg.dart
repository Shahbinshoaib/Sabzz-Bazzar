import 'package:flutter/material.dart';
import 'package:sabzz_bazzar/services/database.dart';
import 'package:sabzz_bazzar/services/loader.dart';


class AddVeg extends StatefulWidget {
  @override
  _AddVegState createState() => _AddVegState();
}

class _AddVegState extends State<AddVeg> {

  final _formkey = GlobalKey<FormState>();
  bool loader = false;

  String _vegName;
  String _vegPrice;
  String _vegPic ;


  @override
  Widget build(BuildContext context) {



    return loader ? Loader() : SingleChildScrollView(
      child: AlertDialog(
        title: Text('Add a vegetable'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
            Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter Vegetable Name' : null,
                  onChanged: (val){
                    setState(() {
                      _vegName = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Vegetable Name',
                  ),
                  keyboardType: TextInputType.name,
                ),
                TextFormField(
                  onChanged: (val){
                    setState(() {
                      _vegPrice = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Price per Kg',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  onChanged: (val){
                    setState(() {
                      _vegPic = val;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Image url',
                  ),
                  keyboardType: TextInputType.url,
                ),
              ],
            ),
          ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('POST', style: TextStyle(color: Colors.red),),
            onPressed: ()async {
              if (_formkey.currentState.validate()){
                setState(() {
                  loader = true;
                });
                await DatabaseService().updateVegData(_vegPic,_vegName,_vegPrice);
                Navigator.pop(context);
                setState(() {
                  loader = false;
                });
              }
            },
          ),
        ],
      ),
    );

  }
}


