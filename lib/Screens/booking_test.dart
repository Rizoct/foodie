import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_firebase_flutter/Model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class BookingTest extends StatefulWidget {
  final String? resto_name;
  final String? resto_desc;
  final String? resto_img;
  final int rid;
  UserModel? loggedInUser = UserModel();


  BookingTest({Key? key, @required this.resto_name, @required this.resto_desc, @required this.resto_img, required this.rid, @required this.loggedInUser}) : super(key: key);

  @override
  _BookingTest createState() => _BookingTest();

}

class _BookingTest extends State<BookingTest>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  DateTime? pickedDate;

  final successSnackBar = const SnackBar(
    content: Text('Data berhasil diinput'),
  );

  final errorSnackBar = const SnackBar(
    content: Text('Data gagal diinput'),
  );

  void initState(){
    _dateInput.text = "";
    super.initState();
  }

  @override
  String getText() {
    if (pickedDate == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(pickedDate!);
    }
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      pickedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      _dateInput.text = getText();
    });

  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: pickedDate ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: pickedDate != null
          ? TimeOfDay(hour: pickedDate!.hour, minute: pickedDate!.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: generateMaterialColor(Colors.redAccent),
        title: Text(widget.resto_name!),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);

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
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    enabled: false,
                                    initialValue: widget.loggedInUser!.firstName! + " " + widget.loggedInUser!.secondName!,
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
                                TextField(
                                  controller: _dateInput, //editing controller of this TextField
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.calendar_today), //icon of text field
                                      labelText: "Enter DateTime" //label text of field
                                  ),
                                  readOnly: true,  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    pickDateTime(context);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      try{
                                        FirebaseFirestore.instance
                                            .collection('restaurants_booking')
                                            .add({'bid': '2',
                                          'jumlah': _jumlahController.text.toString(),
                                          'rid': widget.rid,
                                          'waktubooking': pickedDate.toString(),
                                          'status': 'pending',
                                          'namauser': widget.loggedInUser!.firstName! + " " + widget.loggedInUser!.secondName!,
                                          'uid': widget.loggedInUser!.uid,
                                          'nama_resto': widget.resto_name

                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(successSnackBar)
                                        ;
                                      }catch (e){
                                        print(e.toString());
                                        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                                      }

                                    },
                                  ),
                                ),

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
