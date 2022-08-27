import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/screens/bill.dart';
import 'file:///C:/App/sabzz_bazzar/lib/services/myCart2.dart';
import 'package:sabzz_bazzar/services/database.dart';
import 'package:sabzz_bazzar/models/user.dart';
import 'package:flutter_counter/flutter_counter.dart';


class Mycart extends StatefulWidget {
  @override
  _MycartState createState() => _MycartState();
}

class _MycartState extends State<Mycart> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final myCart = Provider.of<List<Veg>>(context) ?? [];
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return StreamProvider<List<Veg>>.value(
      value: DatabaseService(uid: user.uid,email: user.email).bill,
      child: Container(
        height: h,
        width: w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: h*0.1*myCart.length,
                width: w,
                child: ListView.builder(
                  itemCount: myCart.length,
                  itemBuilder: (context, index){
                    final String itemName = myCart[index].vegName;
                    final String itemPrice = myCart[index].vegPrice;
                    final String itemUrl = myCart[index].vegUrl;
                    return Dismissible(
                      key: Key(itemName),
                      onDismissed: (DismissDirection dir) async{
                      await DatabaseService(uid: user.uid, email: user.email).delDocument(itemName);
                      await DatabaseService(uid: user.uid, email: user.email).delBill(itemName);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('$itemName removed'),
                        action: SnackBarAction(
                          label: 'UNDO',
                        onPressed: () async{
                           await DatabaseService().updateCartData(itemUrl, user.uid, user.email, itemName, itemPrice);
                          },
                        ),
                      ));
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerLeft,
                      ),
                      child: MyCart2(myCart: myCart[index],),
                    );
                  },
                ),
              ),
              Bill(),
            ],
          ),
        ),
      ),
    );
  }
}
