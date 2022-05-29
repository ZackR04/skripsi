import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/detail_task.dart';

class UpdateTaskForm extends StatefulWidget {
  const UpdateTaskForm({Key? key}) : super(key: key);

  @override
  _UpdateTaskFormState createState() => _UpdateTaskFormState();
}

class _UpdateTaskFormState extends State<UpdateTaskForm> {

  var date = DateFormat('dd MMM yyyy').format(DateTime.now());

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  XFile? imagePickedFile;
  LocationData? _userLocation;
  Location location = Location();
  bool showLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 170,
              color: Colors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 270,
                        height: 140,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)
                        ),
                        child: imagePickedFile != null ? Image.file(File(imagePickedFile!.path)) : Icon(Icons.camera_alt_outlined)
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: (){
                        _onImageButtonPressed();
                      },
                      child: Icon(Icons.change_circle),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Tanggal ${date}", style: TextStyle(fontSize: 15, color: Colors.black45)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Detail", style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 7,
                      decoration: InputDecoration(
                        labelText: "Input Detail Update",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            Container(
              width: double.infinity,
              height: 115,
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, right: 20, bottom: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Location", style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    child: showLoad == true ? const CircularProgressIndicator() : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Latitude: ${_userLocation?.latitude ?? "-" }', style:
                        TextStyle(fontSize: 15),),
                        Text('Longitude: ${_userLocation?.longitude ?? "-" }', style:
                        TextStyle(fontSize: 15),),
                        MaterialButton(
                          onPressed: (){
                            _getLocation();
                          },
                          child: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              width: double.infinity,
              height: 60,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => DetailTaskScreen())
                  );
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Update",
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getLocation() async {
    setState(() {
      showLoad = true;
    });
    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
      showLoad = false;
    });
  }

  void _onImageButtonPressed() async {
    pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    setState(() {
      imagePickedFile = pickedFile;
    });
  }
}
