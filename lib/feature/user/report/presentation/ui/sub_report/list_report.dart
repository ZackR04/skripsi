import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_selesai/ui/detail_selesai_screen.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_selesai/ui/item_selesai_screen.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_report/detail_report.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_report/item_list_report.dart';

class ListReportScreen extends StatefulWidget {
  @override
  _ListReportScreenState createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {

  var dio = Dio();
  List? _listItemReport;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataReport();
  }

  void _getDataReport() async {
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_public_report',
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemReport = jsonDecode(response.data);
      });
      print(_listItemReport);
    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        height: double.infinity,
        child: _listItemReport != null ? ListView.builder(
          itemCount: _listItemReport!.length,
          itemBuilder: (context, int index){
            final String _id = _listItemReport![index]['id'];
            final Image _image = Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_reports/'+_listItemReport![index]['img']);
            final String _detailreport = _listItemReport![index]['deskripsi'];
            final String _tglpublish = _listItemReport![index]['tanggal_dibuat'];
            final String _latitude = _listItemReport![index]['lat'];
            final String _longitude = _listItemReport![index]['lng'];
            final double _rating = double.parse(_listItemReport![index]['rating']);
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: _listItemReport![index]['status_report'] != '4' ? ItemListReportScreen(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailReportScreen(
                    id: _id,
                    gambar: _image,
                    deskripsireport: _detailreport,
                    tglpublish: _tglpublish,
                    latitude: _latitude,
                    longitude: _longitude,
                  )));
                },
              )
              : ItemSelesaiScreen(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                rating: _rating,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSelesaiScreen(
                      id: _id,
                      gambar: _image,
                      deskripsireport: _detailreport,
                      tglpublish: _tglpublish,
                      latitude: _latitude,
                      longitude: _longitude,
                      rating: _rating,
                      isReportPublic: true
                  )));
                },
              ),
            );
          },
        )
            : Container(),
      ),
    );
  }
}
