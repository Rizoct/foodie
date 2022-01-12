import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AboutUs extends StatefulWidget {



  AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUs createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs>{
  String dummy = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: generateMaterialColor(Colors.redAccent),
          title: Text("About Us"),
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
            SizedBox(
                height: 200,
                child: Image.asset(
                  "assets/images/1.png",
                  fit: BoxFit.contain,
                )),
            const SizedBox(height: 45),
            const Center(
              child: Text("FOODIE DINING APPS", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(dummy)
            )
          ],

        )
    );
  }
}
