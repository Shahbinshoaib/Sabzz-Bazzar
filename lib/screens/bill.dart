import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/models/user.dart';

class Bill extends StatefulWidget {

  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {


  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final bill = Provider.of<List<Veg>>(context) ?? [];
    double sum = 0.0;
    for (var i = 0; i < bill.length; i++) {
      double one = double.parse(bill[i].vegPrice);
      sum += one;
    }


    return Container(
      child: Column(
        children: [
          Divider(height: 0.5,),
          SizedBox(height: h*0.015,),
          ListTile(
            title: Text('Quantity: ',style: TextStyle(fontSize: h*0.02),),
            trailing: Text('${bill.length}.0',style: TextStyle(fontSize: h*0.02),),
          ),
          SizedBox(height: h*0.010,),
          ListTile(
            title: Text('Subtotal: ',style: TextStyle(fontSize: h*0.02),),
            trailing: Text('$sum',style: TextStyle(fontSize: h*0.02),),
          ),
          SizedBox(height: h*0.010,),
          ListTile(
            title: Text('Discount: ',style: TextStyle(fontSize: h*0.02),),
            trailing: Text('0%',style: TextStyle(fontSize: h*0.02),),
          ),
          SizedBox(height: h*0.010,),
          ListTile(
            title: Text('Delivery Charges: ',style: TextStyle(fontSize: h*0.02),),
            trailing: Text('Rs. 30.00',style: TextStyle(fontSize: h*0.02),),
          ),
          SizedBox(height: h*0.010,),
          ListTile(
            title: Text('Total: ',style: TextStyle(fontSize: h*0.02,fontWeight: FontWeight.bold),),
            trailing: Text('Rs. ${sum+30}',style: TextStyle(fontSize: h*0.02,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: h*0.020,),
          ButtonTheme(
            height: h*0.05,
            minWidth: w*0.8,
            child: RaisedButton(
              onPressed: (){

              },
              color: Colors.green[600],
              child: Text('GO TO CHECKOUT',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
            ),
          ),
          SizedBox(height: h*0.020,),
        ],
      ),
    );
  }
}
