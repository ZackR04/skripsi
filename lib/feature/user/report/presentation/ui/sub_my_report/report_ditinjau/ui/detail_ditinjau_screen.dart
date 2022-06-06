import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_ditinjau/ui/form_editreport.dart';

class DetailDitinjauScreen extends StatefulWidget {
  final Image? gambar;
  final String? deskripsireport;
  final String? waktureport;
  final String? tglpublish;
  final String? latitude;
  final String? longitude;
  final String? id;

  const DetailDitinjauScreen(
      {Key? key,
      this.gambar,
      this.deskripsireport,
      this.waktureport,
      this.tglpublish,
      this.latitude,
      this.longitude,
      this.id,})
      : super(key: key);

  @override
  _DetailDitinjauScreenState createState() => _DetailDitinjauScreenState();
}

class _DetailDitinjauScreenState extends State<DetailDitinjauScreen> {

  var dio = Dio();
  bool _showLoading = false;
  String msg_error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: widget.gambar,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.blue.shade200),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Ditinjau!", style: TextStyle(fontSize: 20, color: Colors.orange),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Report anda sedang dalam peninjauan",
                              style: TextStyle(fontSize: 17)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child:  Text("Tanggal Publish ${widget.tglpublish}"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:Text(
                              "Lokasi",
                              style: TextStyle(fontSize: 20),
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Latitude : ${widget.latitude}"),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Longitude : ${widget.longitude}"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Detail Report",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.deskripsireport!,
                          style: TextStyle(fontSize: 15),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => EditReportScreen(
                                  id: widget.id,
                                  gambar: widget.gambar,
                                  tglpublish: widget.tglpublish,
                                  deskripsireport: widget.deskripsireport,
                                  latitude: widget.latitude,
                                  longitude: widget.longitude,
                                ))
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline_outlined),
                              onPressed: (){
                                _deleteReport(widget.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _deleteReport(String? id) async {
    var formData = FormData.fromMap({
      'id_report': id,
    });

    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/delete_report',
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
