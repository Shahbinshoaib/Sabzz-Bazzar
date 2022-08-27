import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/models/user.dart';
import 'package:sabzz_bazzar/services/database.dart';

class VegList2 extends StatefulWidget {

  final Veg vegs;
  const VegList2({Key key, this.vegs}) : super(key: key);

  @override
  _VegList2State createState() => _VegList2State();
}

class _VegList2State extends State<VegList2> {

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Card(
        elevation: 5.0,
        margin: EdgeInsets.fromLTRB(w*0.06, h*0.018, w*0.06, 0.0),
        child: Row(
          children: [
            loader ? Loader2() : Image.network(widget.vegs.vegUrl ?? 'https://thumbs.gfycat.com/FlippantContentFlickertailsquirrel-small.gif',height: h*0.2,fit: BoxFit.fill,width: w*0.4,),
            Padding(
              padding:  EdgeInsets.fromLTRB(w*0.05, 0, w*0.1, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.vegs.vegName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: h*0.035,color: Colors.black),),
                  Text('Rs.${widget.vegs.vegPrice}/kg',style: TextStyle(fontSize: h*0.025,color: Colors.black45),),
                  SizedBox(height: h*0.03,),
                   RaisedButton(
                    color: Colors.green[600],
                    child: Row(
                      children: [
                        Icon(Icons.add_shopping_cart,color: Colors.white,),
                        Text('Add to Cart',style: TextStyle(color: Colors.white),),
                      ],
                    ) ,
                    onPressed: () async{
                      setState(() {
                        loader = true;
                      });
                      await DatabaseService().updateCartData(widget.vegs.vegUrl, user.uid, user.email, widget.vegs.vegName, widget.vegs.vegPrice);
                      setState(() {
                        loader = false;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}

class Loader2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      child: Center(
        child: Image.asset('assets/loading2.gif',height: h*0.2,fit: BoxFit.fill,width: w*0.4),
      ),
    );
  }
}
