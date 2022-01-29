import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class RejectCancel extends StatefulWidget {
  String? uid;

  RejectCancel({Key? key, @required this.uid}) : super(key: key);

  @override
  _RejectCancel createState() => _RejectCancel();
}

class _RejectCancel extends State<RejectCancel>{

  @override
  Widget build(BuildContext context) {
    Widget _buildList(QuerySnapshot snapshot) {
      return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          return Card(
            elevation: 5,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(doc["nama_resto"], style: TextStyle(fontSize: 17),),
              ),
              subtitle: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  children: [
                    WidgetSpan(
                        child: Icon(
                          Icons.accessibility,
                          size: 40,
                        )),
                    TextSpan(text: doc["jumlah"], style: TextStyle(color: Colors.blue)),
                    TextSpan(
                        text: " | Date = " + doc["waktubooking"])
                  ],
                ),
                textScaleFactor: 0.5,
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: generateMaterialColor(Colors.redAccent),
          title: Text("Rejected/Cancelled"),
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
                  .collection("restaurants_booking")
                  .where("uid", isEqualTo: widget.uid)
                  .where("status", isEqualTo: "cancelled")
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
        )
    );
  }
}
