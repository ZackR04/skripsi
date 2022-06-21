import 'dart:convert';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geoloc;

class UpdateTaskForm extends StatefulWidget {
  const UpdateTaskForm({Key? key}) : super(key: key);

  @override
  _UpdateTaskFormState createState() => _UpdateTaskFormState();
}

class _UpdateTaskFormState extends State<UpdateTaskForm> {

  var date = DateFormat('dd MMM yyyy').format(DateTime.now());
  var dio = Dio();
  var address = '';
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  XFile? imagePickedFile;
  LocationData? _userLocation;
  Location location = Location();
  bool showLoad = false;
  TextEditingController detailTask = new TextEditingController();
  bool _showLoading = false;
  String msg_error = '';
  String alamat = '';

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
                    child: Text("Detail Update", style: TextStyle(fontSize: 20)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: detailTask,
                      maxLines: 8,
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
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, right: 20, top: 5),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(alamat, style: TextStyle(fontSize: 17),),
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
                  _addTask(imagePickedFile, date ,detailTask.text, '${_userLocation?.latitude}', '${_userLocation?.longitude}');
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
    if(_locationData != null){
      List<geoloc.Placemark> placemarks = await geoloc.placemarkFromCoordinates(_locationData.latitude!, _locationData.longitude!);
      setState(() {
        _userLocation = _locationData;
        alamat = '${placemarks.first.street} ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}, ${placemarks.first.postalCode}';
        showLoad = false;
      });
    }
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

  void _addTask(XFile? imagePickedFile, String date, String detailTask, String latitude, String longitude) async {

    if(imagePickedFile == null){
      setState(() {
        _showLoading = false;
        msg_error = "Image tidak boleh kosong";
      });
    }
    else if (detailTask == ''){
      setState(() {
        _showLoading = false;
        msg_error = "Detail Report harus diisi";
      });
    }else {
      dio.options.headers = {
        'Content-Type': 'application/form-data'
      };
    }

    var formData = FormData.fromMap({
      'tgl_update': date,
      'image_task': await MultipartFile.fromFile(imagePickedFile!.path, filename: 'upload.jpg'),
      'detail_update': detailTask,
      'lat': latitude,
      'lng': longitude,
    });

    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiTask/add_task',
        data: formData
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.data);
      if (data['status_message'] == 'success') {
        await CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: '${data['message']}',
            autoCloseDuration: const Duration(seconds: 10),
            confirmBtnText: 'Ok!',
            onConfirmBtnTap: (){}
        );

        Navigator.pushReplacementNamed(context, '/detailtask');

      }else{
        setState(() {
          _showLoading = false;
          msg_error = "Maaf, system sedang error";
        });
      }
    }
  }
}
