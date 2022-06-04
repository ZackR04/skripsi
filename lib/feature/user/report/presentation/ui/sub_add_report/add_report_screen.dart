import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sub_my_report/list_myreport_screen.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({Key? key}) : super(key: key);

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {

  var dio = Dio();
  bool _showLoading = false;
  final ImagePicker _picker = ImagePicker();
  TextEditingController detailReport = new TextEditingController();
  XFile? pickedFile;
  XFile? imagePickedFile;
  LocationData? _userLocation;
  Location location = Location();
  bool showLoad = false;
  String msg_error = '';

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
        title: Text("Add Report"),
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
                      controller: detailReport,
                      maxLines: 8,
                      decoration: InputDecoration(
                        labelText: "Input Detail Report",
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
              padding: EdgeInsets.only(top: 30),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              width: double.infinity,
              height: 60,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: (){
                  setState(() {
                    _showLoading = true;
                  });
                  _addProcess(imagePickedFile, detailReport.text, '${_userLocation?.latitude}', '${_userLocation?.longitude}');
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Publish",
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

  void _addProcess(XFile? imagePickedFile, String detailReport, String latitude, String longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(imagePickedFile == null){
      setState(() {
        _showLoading = false;
        msg_error = "Image tidak boleh kosong";
      });
    }
    else if (detailReport == ''){
      setState(() {
        _showLoading = false;
        msg_error = "Detail Report harus diisi";
      });
    }else {
      var formData = FormData.fromMap({
        'image': imagePickedFile,
        'deskripsi': detailReport,
        'lat': latitude,
        'lng': longitude,
        'id_user': prefs.getString('id'),
        'status_report': 0,
      });

      final response = await dio.post(
          'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/add_report',
          data: formData
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        if (data['status_message'] == 'success') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ListMyReportScreen(idtab: 1,))
          );
        }else{
          setState(() {
            _showLoading = false;
            msg_error = "Maaf, system sedang error";
          });
        }
      }
    }
  }
}
