import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sabzz_bazzar/models/user.dart';

class DatabaseService{

  final String uid;
  final String email;
  DatabaseService({this.uid, this.email});

  final CollectionReference vegCollection = Firestore.instance.collection('Vegetables');
  final CollectionReference myCartCollection = Firestore.instance.collection('My Cart');
  final CollectionReference billCollection = Firestore.instance.collection('Bill');


  Future updateVegData(String vegPic, String vegName, String vegPrice,) async{
    return await vegCollection.document(vegName).setData({
      'Veg Pic' : vegPic,
      'Veg Name' : vegName,
      'Veg Price': vegPrice,
    });
  }

  Future updateCartData(String vegPic, String uid, String email, String vegName, String vegPrice) async{
    return await myCartCollection.document(uid).collection(email).document(vegName).setData({
      'Veg Pic' : vegPic,
      'Veg Name' : vegName,
      'Veg Price': vegPrice,
    });
  }
  Future updateBillData(String vegPic, String uid, String email, String vegName, String vegPrice) async{
    return await billCollection.document(uid).collection(email).document(vegName).setData({
      'Veg Pic' : vegPic,
      'Veg Name' : vegName,
      'Veg Price': vegPrice,
    });
  }
  //del user doucment
  Future delDocument(String vegName) async{
    return await myCartCollection.document(uid).collection(email).document(vegName).delete();
  }
  Future delBill(String vegName) async{
    return await billCollection.document(uid).collection(email).document(vegName).delete();
  }


  List<Veg> _vegListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Veg(
        vegName: doc.data['Veg Name'] ?? '',
        vegPrice: doc.data['Veg Price'] ?? '0',
        vegUrl: doc.data['Veg Pic'] ?? null,
      );
    }).toList();
  }

  //get Vegitem Stream
Stream<List<Veg>> get vegs {
    return vegCollection.snapshots()
        .map(_vegListFromSnapshot);
}
  //get Stream for user cart
  Stream<List<Veg>> get myCart {
    return myCartCollection.document(uid).collection(email).snapshots()
        .map(_vegListFromSnapshot);
  }
  Stream<List<Veg>> get bill {
    return billCollection.document(uid).collection(email).snapshots()
        .map(_vegListFromSnapshot);
  }



}