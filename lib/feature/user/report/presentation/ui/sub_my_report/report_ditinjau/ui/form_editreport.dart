import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../list_myreport_screen.dart';

class EditReportScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? waktureport;
  final String? tglpublish;
  final String? latitude;
  final String? longitude;

  const EditReportScreen(
      {Key? key,
        this.gambar,
        this.deskripsireport,
        this.waktureport,
        this.tglpublish,
        this.latitude,
        this.longitude,}) : super(key: key);

  @override
  _EditReportScreenState createState() => _EditReportScreenState();
}

class _EditReportScreenState extends State<EditReportScreen> {

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  XFile? imagePickedFile;
  LocationData? _userLocation;
  Location location = Location();
  TextEditingController? deskripsitext;
  bool showLoad = false;

  String lat = '';
  String lng = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
    deskripsitext = TextEditingController(text: widget.deskripsireport);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Report"),
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
              height: 230,
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Detail Report", style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: deskripsitext,
                      maxLines: 8,
                      decoration: InputDecoration(
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
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              width: double.infinity,
              height: 125,
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
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
                        Text('Latitude: ${lat == '' ? widget.latitude : lat}', style:
                          TextStyle(fontSize: 15)),
                        Text('Longitude: ${lng == '' ? widget.longitude : lng}', style:
                        TextStyle(fontSize: 15)),
                        MaterialButton(
                          onPressed: (){
                            setState(() {
                              _getLocation();
                            });
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
              padding: EdgeInsets.only(top: 30),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              width: double.infinity,
              height: 60,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ListMyReportScreen(idtab: 1,))
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
                  child: Text("Save Edit",
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}
