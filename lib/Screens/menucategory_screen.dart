import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuCategory extends StatefulWidget {
  String? kategori;


  MenuCategory({Key? key, @required this.kategori}) : super(key: key);

  @override
  _MenuCategory createState() => _MenuCategory();
}

class _MenuCategory extends State<MenuCategory>{
  @override
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
            Center(
              child: Text(widget.kategori!, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),),
            ),
          ],

        )
    );
  }
}
