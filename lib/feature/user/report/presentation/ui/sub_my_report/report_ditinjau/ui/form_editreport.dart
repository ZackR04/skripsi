import 'dart:convert';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditReportScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? waktureport;
  final String? tglpublish;
  final String? latitude;
  final String? longitude;
  final String? id;

  const EditReportScreen(
      {Key? key,
        this.gambar,
        this.deskripsireport,
        this.waktureport,
        this.tglpublish,
        this.latitude,
        this.longitude,
        this.id}) : super(key: key);

  @override
  _EditReportScreenState createState() => _EditReportScreenState();
}

class _EditReportScreenState extends State<EditReportScreen> {

  var dio = Dio();
  bool _showLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  XFile? imagePickedFile;
  LocationData? _userLocation;
  Location location = Location();
  var deskripsitext;
  bool showLoad = false;
  String msg_error = '';

  String lat = '';
  String lng = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deskripsitext = TextEditingController(text: widget.deskripsireport);
    setshowimage();
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
                        child: setshowimage()
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
                  _editProcess(imagePickedFile, deskripsitext.text, '${_userLocation?.latitude}', '${_userLocation?.longitude}');
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
      lat = '${_userLocation?.latitude}';
      lng = '${_userLocation?.longitude}';
      showLoad = false;
    });
  }

  void _editProcess(XFile? imagePickedFile, String deskripsireport, String latitude, String longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (deskripsireport == ''){
      print('jalan2');
      setState(() {
        _showLoading = false;
        msg_error = "Detail Report harus diisi";
      });
    }else {
      print('jalan');
      dio.options.headers = {
        'Content-Type': 'application/form-data'
      };
      var formData = FormData.fromMap({
        'image_report': imagePickedFile == null ? '' : await MultipartFile.fromFile(imagePickedFile.path, filename: 'upload.jpg'),
        'deskripsi': deskripsireport,
        'lat': latitude,
        'lng': longitude,
        'id_user': prefs.getString('id'),
        'id': widget.id,
      });

      final response = await dio.post(
          'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/update_report',
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

          Navigator.pushReplacementNamed(context, '/myreport');

        }else{
          setState(() {
            _showLoading = false;
            msg_error = "Maaf, system sedang error";
          });
        }
      }
    }
  }

  Image? setshowimage() {
    if(imagePickedFile == null){
      return widget.gambar;
    } else {
      return Image.file(File(imagePickedFile!.path));
    }
  }
}
