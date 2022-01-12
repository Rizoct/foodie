import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingTest extends StatefulWidget {
  final String? resto_name;
  final String? resto_desc;
  final String? resto_img;
  final String? rid;
  final String? uid;


  BookingTest({Key? key, @required this.resto_name, @required this.resto_desc, @required this.resto_img, @required this.rid, @required this.uid}) : super(key: key);

  @override
  _BookingTest createState() => _BookingTest();
}

class _BookingTest extends State<BookingTest>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: generateMaterialColor(Colors.redAccent),
        title: Text(widget.resto_name!),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(widget.resto_img!, fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(widget.resto_desc!, style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(360, 50),
                primary: Color(0xff4C4C6D),
                onPrimary: Colors.white),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: 200,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              DataTable(
                                columns: const [
                                  DataColumn(label: Text(
                                      'ID',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                  )),
                                  DataColumn(label: Text(
                                      'Makanan',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                  )),
                                  DataColumn(label: Text(
                                      'Harga',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                  )),
                                ],
                                rows: const [
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('Ayam')),
                                    DataCell(Text('20.000')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('2')),
                                    DataCell(Text('Bebek')),
                                    DataCell(Text('30.000')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('3')),
                                    DataCell(Text('Lele')),
                                    DataCell(Text('40.000')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('4')),
                                    DataCell(Text('Gurame')),
                                    DataCell(Text('50.000')),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Text("Menu"),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(360, 50),
                primary: Color(0xff4C4C6D),
                onPrimary: Colors.white),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                /*Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
                                  child: ElevatedButton(
                                    child: Text("Select Date"),
                                    onPressed: (){
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2021),
                                          builder: (BuildContext context, Widget ?child){
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme: ColorScheme.dark(
                                                  primary: generateMaterialColor(const Color(0xFFFFE194)),
                                                  onPrimary: Colors.white,
                                                  surface: generateMaterialColor(const Color(0xFFFFE194)),
                                                  onSurface: Colors.black,
                                                ),
                                                dialogBackgroundColor:Colors.white,
                                              ),
                                              child: child!,
                                            );
                                          },
                                          lastDate: DateTime(2040));
                                    },
                                  ),
                                ),*/

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Nama'
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _jumlahController,
                                    decoration: InputDecoration(
                                        hintText: 'Jumlah Orang'
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                        .collection('restaurants_booking')
                                        .add({'bid': '2', 'jumlah': _jumlahController.text.toString(), 'rid': widget.rid, 'uid': widget.uid});

                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Text("Booking"),
          ),
        ),

      ]),
    );
  }
}
