import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Screens/aboutus_screen.dart';
import 'package:login_firebase_flutter/Screens/history_screen.dart';
import 'package:login_firebase_flutter/Screens/login_screen.dart';
import 'package:login_firebase_flutter/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/booking_test.dart';
import 'package:login_firebase_flutter/Screens/booking_user.dart';
import 'package:login_firebase_flutter/Screens/menucategory_screen.dart';
import 'package:login_firebase_flutter/Screens/userprofile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text("Foodie");

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        final doc = snapshot.docs[index];
        return GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BookingTest(
                resto_name: doc["nama_resto"],
                resto_desc: doc["desc_resto"],
                resto_img: doc["img"],
                rid: doc["rid"].toString(),
                uid: loggedInUser.uid,
              )),
            );
          },
          child: ListTile(
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 120,
                minHeight: 200,
                maxWidth: 120,
                maxHeight: 200,
              ),
              child: Image.network(doc["img"], fit: BoxFit.cover),
            ),
            title: Text(doc["nama_resto"]),
            subtitle: Text(doc["desc_resto"]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        appBar: AppBar(
          title: customSearchBar,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _drawerKey.currentState?.openDrawer(),
          ),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
                onPressed: () {
                  if (customIcon.icon == Icons.search) {
                    customIcon = Icon(Icons.cancel);
                    customSearchBar = const TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    );
                  } else {
                    customIcon = Icon(Icons.search);
                    customSearchBar = Text("Foodie");
                  }
                },
                icon: customIcon)
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfile(loggedInUser: loggedInUser,),
                        ));
                      },
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture: CircleAvatar(
                            backgroundImage:
                            NetworkImage("${loggedInUser.img}")),
                        accountEmail: Text(
                          "${loggedInUser.email}",
                          style: TextStyle(color: Colors.black),
                        ),
                        accountName: Text(
                          '${loggedInUser.firstName} ${loggedInUser.secondName}',
                          style: TextStyle(fontSize: 24.0, color: Colors.black),
                        ),
                        decoration: BoxDecoration(color: Colors.redAccent),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingUser()),
                        );
                      },
                      child: ListTile(
                        title: Text("Booking"),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryUser()),
                        );
                      },
                      child: ListTile(
                        title: Text("History"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Divider(),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs()),
                              );
                            },
                            child: ListTile(title: Text('About Us')),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _signOut();
                              if (_firebaseAuth.currentUser == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              }
                            },
                            child: ListTile(title: Text('Log Out')),
                          )
                        ],
                      ))))
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            /*CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.5,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),*/
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Western.png'),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 80, left: 25),
                                  child: Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        'Western',
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 6
                                            ..color = Colors.white,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      const Text(
                                        'Western',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuCategory(kategori: 'Western')),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Japanese.png'),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                padding: EdgeInsets.only(top: 80, left: 25),
                                child: Stack(
                                  children: <Widget>[
                                    // Stroked text as border.
                                    Text(
                                      'Japanese',
                                      style: TextStyle(
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 6
                                          ..color = Colors.white,
                                      ),
                                    ),
                                    // Solid text as fill.
                                    Text(
                                      'Japanese',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuCategory(kategori: 'Japanese')),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Indonesian.png'),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 80, left: 25),
                                  child: Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        'Indonesian',
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 6
                                            ..color = Colors.white,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        'Indonesian',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuCategory(kategori: 'Indonesian')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Korean.png'),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 80, left: 33.5),
                                  child: Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        'Korean',
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 6
                                            ..color = Colors.white,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        'Korean',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuCategory(kategori: 'Korean')),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Desserts.png'),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 80, left: 25),
                                  child: Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        'Desserts',
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 6
                                            ..color = Colors.white,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        'Desserts',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuCategory(kategori: 'Desserts')),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Chinese.png'),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 80, left: 25),
                                  child: Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        'Chinese',
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 6
                                            ..color = Colors.white,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        'Chinese',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuCategory(kategori: 'Chinese')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 36),
                          children: [
                            WidgetSpan(
                                child: Icon(
                              Icons.location_on,
                              size: 40,
                            )),
                            TextSpan(text: 'Showing Restaurant in '),
                            TextSpan(
                                text: 'Malang',
                                style: TextStyle(color: Colors.blue))
                          ],
                        ),
                        textScaleFactor: 0.5,
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants_test")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return LinearProgressIndicator();
                        return SizedBox(
                          height: 300,
                          child: _buildList(snapshot.data!),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
