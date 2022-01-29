import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/booking_test.dart';
import 'package:login_firebase_flutter/Screens/booking_user.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase_flutter/Model/user_model.dart';
import 'package:firestore_search/firestore_search.dart';

class SearchScreen extends StatefulWidget {
  UserModel? userModel = UserModel();

  SearchScreen({Key? key, @required this.userModel}) : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class DataModel {
  final String? resto_name;
  final String? type;
  final int? rid;

  DataModel({this.resto_name, this.type, this.rid});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return DataModel(
          resto_name: dataMap['restoname'], type: dataMap['restotype'], rid: dataMap['rid']);
    }).toList();
  }
}

class _SearchScreen extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: FirestoreSearchScaffold(
            firestoreCollectionName: 'restaurant_data',
            appBarBackgroundColor: Colors.redAccent,
            searchBy: 'restoname',
            scaffoldBody: Center(),
            dataListFromSnapshot: DataModel().dataListFromSnapshot,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DataModel>? dataList = snapshot.data;
                if (dataList!.isEmpty) {
                  return const Center(
                    child: Text('No Results Returned'),
                  );
                }
                return ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final DataModel data = dataList[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingTest(rid: data.rid!)),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${data.resto_name}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 8.0, right: 8.0),
                              child: Text('${data.type}',
                                  style: Theme.of(context).textTheme.bodyText1),
                            )
                          ],
                        ),
                      );
                    });
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No Results Returned'),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    ));
  }
}
