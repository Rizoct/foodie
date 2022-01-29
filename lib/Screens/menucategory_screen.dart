import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/booking_test.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase_flutter/Model/user_model.dart';

class MenuCategory extends StatefulWidget {
  String? kategori;
  UserModel loggedInUser = UserModel();

  MenuCategory({Key? key, @required this.kategori, required this.loggedInUser}) : super(key: key);

  @override
  _MenuCategory createState() => _MenuCategory();
}

class _MenuCategory extends State<MenuCategory>{
  @override

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
                resto_name: doc["restoname"],
                resto_desc: doc["restotype"],
                resto_img: doc["restoimg"],
                rid: doc["rid"],
                loggedInUser: widget.loggedInUser,
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
              child: Image.network(doc["restoimg"], fit: BoxFit.cover),
            ),
            title: Text(doc["restoname"]),
            subtitle: Text(doc["restotype"]),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: generateMaterialColor(Colors.redAccent),
          title: Text(widget.kategori!),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }),
        ),
        body: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("restaurant_data")
                  .where("restotype", isEqualTo: widget.kategori!)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return SizedBox(
                  height: 350,
                  child: _buildList(snapshot.data!),
                );
              },
            )
          ],

        )
    );
  }
}
