
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabzz_bazzar/models/user.dart';
import 'package:sabzz_bazzar/screens/addVeg.dart';
import 'package:sabzz_bazzar/screens/myCart.dart';
import 'package:sabzz_bazzar/screens/vegList.dart';
import 'package:sabzz_bazzar/services/auth.dart';
import 'package:sabzz_bazzar/services/database.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final AuthService _auth = AuthService();

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    final myCart = Provider.of<List<Veg>>(context) ?? [];
    final user = Provider.of<User>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Future<void> _showlogoutDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to logout?'),
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
                child: Text('LOGOUT', style: TextStyle(color: Colors.red),),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    final drawerHeader = UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Colors.green[600]
      ),
      accountName: Text(user.username ?? ' '),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        radius: 20.0,
        child: Image.network(user.photo),
        backgroundColor: Colors.transparent,
      ),
    );

    void _showAddCoursePanel(){
      showDialog(context: context, builder: (BuildContext context) {
        return Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
            child: AddVeg()
        );
      });
    }


    return StreamProvider<List<Veg>>.value(
      value: DatabaseService().vegs,
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  actions: [
                    user.email == 'shahbinshoaib@gmail.com' ?
                      IconButton(icon: Icon(Icons.add_circle,color: Colors.white,), onPressed: (){
                        _showAddCoursePanel();
                      },iconSize: h*0.03,) : null,
                  ],
                  backgroundColor: Colors.green[600],
                  expandedHeight: h*0.4,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Home",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          )),
                      background: Image.asset('assets/veg.jpg',fit: BoxFit.fill,)),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.green[600],
                      tabs: [
                        Tab( text: "Vegetables"),
                        Tab( text: "Fruits"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                VegList(),
                Align(
                  alignment: Alignment.center,
                    child: Text('Coming Soon...',style: TextStyle(fontSize: h*0.02),)),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            child: ListView(
              children: [
                drawerHeader,
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      _showlogoutDialog();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Stack(
          children: [
            FloatingActionButton(
              mini: false,
              autofocus: true,
              backgroundColor: Colors.green[600],
              onPressed: (){
                Navigator.of(context).push(_NewPage1());
              },
              child: Icon(Icons.shopping_cart,color: Colors.white,),
            ),
            myCart.length != 0 ? new Positioned(
              right: 8,
              top: 1,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(30),
                ),
                constraints: BoxConstraints(
                  minHeight: 14,
                  minWidth: 14,
                ),
                child: Text('${myCart.length}',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
              ),
            ) : FloatingActionButton(
              mini: false,
              autofocus: true,
              backgroundColor: Colors.green[600],
              onPressed: (){
              },
              child: Icon(Icons.shopping_cart,color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _NewPage1 extends MaterialPageRoute<Null> {
  _NewPage1()
      : super(builder: (BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Veg>>.value(
      value: DatabaseService(email: user.email, uid: user.uid).myCart,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green[600],
          title: Row(
            children: <Widget>[
              Text('My Cart'),
            ],
          ),
        ),
        body: Mycart(),
      ),
    );
  });
}