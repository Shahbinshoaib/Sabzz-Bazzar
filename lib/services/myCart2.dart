import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/models/user.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:sabzz_bazzar/services/database.dart';

class MyCart2 extends StatefulWidget {

  final Veg myCart;
  const MyCart2({Key key, this.myCart}) : super(key: key);

  @override
  _MyCart2State createState() => _MyCart2State();
}

class _MyCart2State extends State<MyCart2> {

  bool loader = false;
  num _n = 0;


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final user = Provider.of<User>(context);

    return ListTile(
      leading: Image.network(widget.myCart.vegUrl,fit: BoxFit.fill , width: w*0.15,),
      title: Text('${widget.myCart.vegName}'),
      subtitle: Text('Rs. ${widget.myCart.vegPrice}'),
      isThreeLine: true,
      trailing: Counter(
        color: Colors.green[600],
        initialValue: _n,
        minValue: 0,
        maxValue: 10,
        step: 0.25,
        decimalPlaces: 2,
        onChanged: (value) async { // get the latest value from here
          setState(() {
            _n = value;
          });
          var one = int.parse(widget.myCart.vegPrice);
          await DatabaseService().updateBillData(widget.myCart.vegUrl, user.uid, user.email, widget.myCart.vegName, '${one*_n}');
        },
      ),
    );
  }
}
