import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase_flutter/Model/user_model.dart';
import 'dart:io';

class UserProfile extends StatefulWidget {
  String? useravatar;
  UserModel? loggedInUser = UserModel();

  UserProfile({Key? key, @required this.loggedInUser}) : super(key: key);

  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _secondname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: generateMaterialColor(Colors.redAccent),
          title: Text("Edit Profil"),
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
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                  },
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(widget.loggedInUser!.img!),
                    backgroundColor: Colors.transparent,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 36),
                  children: [
                    TextSpan(text: 'Identitas'),
                  ],
                ),
                textScaleFactor: 0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                initialValue: widget.loggedInUser!.firstName!,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    label: Text("Firstname"),
                    //hintText: widget.loggedInUser!.firstName!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                  initialValue: widget.loggedInUser!.secondName!,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    label: Text("Secondname"),
                    //hintText: widget.loggedInUser!.secondName!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                  enabled: false,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    label: Text(widget.loggedInUser!.email!),
                    hintText: widget.loggedInUser!.email!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(360, 50),
                    primary: Color(0xff4C4C6D),
                    onPrimary: Colors.white),
                child: Text("Update"),
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}
