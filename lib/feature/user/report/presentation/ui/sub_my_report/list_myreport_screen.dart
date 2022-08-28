import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_ditinjau/ui/detail_ditinjau_screen.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_ditolak/ui/detail_ditolak_screen.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_ditolak/ui/item_ditolak_screen.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_selesai/ui/detail_selesai_screen.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/report_selesai/ui/item_selesai_screen.dart';
import '../sub_report/detail_report.dart';
import '../sub_report/item_list_report.dart';

class ListMyReportScreen extends StatefulWidget {

  final int idtab;

  const ListMyReportScreen({Key? key,
  required this.idtab}) : super(key: key);

  @override
  _ListMyReportScreenState createState() => _ListMyReportScreenState();
}

class _ListMyReportScreenState extends State<ListMyReportScreen> {

  var dio = Dio();

  List? _listItemDitinjau;

  List? _listItemDiproses;

  List? _listItemSelesai;

  List? _listItemDitolak;

  var prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
  }

  void _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _getDataDitinjau();
    _getDataDiproses();
    _getDataSelesai();
    _getDataDitolak();
  }

  void _getDataDitinjau() async {
    var formData = FormData.fromMap({
      'id_user': prefs.getString('id'),
      'status_report': 0
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_report',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemDitinjau = jsonDecode(response.data);
      });
      print(_listItemDitinjau);
    }else{
      print('Failed');
    }
  }

  void _getDataDiproses() async {
    var formData = FormData.fromMap({
      'id_user': prefs.getString('id'),
      'status_report': 2
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_report',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemDiproses = jsonDecode(response.data);
      });
      print(_listItemDiproses);
    }else{
      print('Failed');
    }
  }

  void _getDataSelesai() async {
    var formData = FormData.fromMap({
      'id_user': prefs.getString('id'),
      'status_report': 4
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_report',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemSelesai = jsonDecode(response.data);
      });
      print(_listItemSelesai);
    }else{
      print('Failed');
    }
  }

  void _getDataDitolak() async {
    var formData = FormData.fromMap({
      'id_user': prefs.getString('id'),
      'status_report': 3
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_report',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemDitolak = jsonDecode(response.data);
      });
      print(_listItemDitolak);
    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      height: double.infinity,
      child: widget.idtab == 1
          ?
      _listItemDitinjau != null
          ?
      ListView.builder(
        itemCount: _listItemDitinjau!.length,
        itemBuilder: (context, index){
          print(index);
          final String _id = _listItemDitinjau![index]['id'];
          final Image _image = Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_reports/'+_listItemDitinjau![index]['img']);
          final String _detailreport = _listItemDitinjau![index]['deskripsi'];
          final String _tglpublish = _listItemDitinjau![index]['tanggal_dibuat'];
          final String _latitude = _listItemDitinjau![index]['lat'];
          final String _longitude = _listItemDitinjau![index]['lng'];
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemListReportScreen(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDitinjauScreen(
                    id: _id,
                    gambar: _image,
                    deskripsireport: _detailreport,
                    tglpublish: _tglpublish,
                    latitude: _latitude,
                    longitude: _longitude,
                  )));
                },
              )
          );
        },
      )
          :
      Container()
          :
      widget.idtab == 2
          ?
      _listItemDiproses != null
          ?
      ListView.builder(
        itemCount: _listItemDiproses!.length,
        itemBuilder: (context, index){
          print(index);
          final String _id = _listItemDiproses![index]['id'];
          final Image _image = Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_reports/'+_listItemDiproses![index]['img']);
          final String _detailreport = _listItemDiproses![index]['deskripsi'];
          final String _tglpublish = _listItemDiproses![index]['tanggal_dibuat'];
          final String _latitude = _listItemDiproses![index]['lat'];
          final String _longitude = _listItemDiproses![index]['lng'];
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemListReportScreen(
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
          );
        },
      )
          :
      Container()
          :
      widget.idtab == 3
          ?
      _listItemSelesai != null
          ?
      ListView.builder(
        itemCount: _listItemSelesai!.length,
        itemBuilder: (context, index){
          print(index);
          final String _id = _listItemSelesai![index]['id'];
          final Image _image = Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_reports/'+_listItemSelesai![index]['img']);
          final String _detailreport = _listItemSelesai![index]['deskripsi'];
          final String _tglpublish = _listItemSelesai![index]['tanggal_dibuat'];
          final String _latitude = _listItemSelesai![index]['lat'];
          final String _longitude = _listItemSelesai![index]['lng'];
          final double _rating = double.parse(_listItemSelesai![index]['rating']);
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemSelesaiScreen(
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
                      isReportPublic: false
                  )));
                },
              )
          );
        },
      )
          :
      Container()
          :
      widget.idtab == 4
          ?
      _listItemDitolak != null
          ?
      ListView.builder(
        itemCount: _listItemDitolak!.length,
        itemBuilder: (context, index){
          print(index);
          final Image _image = Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_reports/'+_listItemDitolak![index]['img']);
          final String _detailreport = _listItemDitolak![index]['deskripsi'];
          final String _tglpublish = _listItemDitolak![index]['tanggal_dibuat'];
          final String _noteditolak = _listItemDitolak![index]['noteditolak'];
          final String _latitude = _listItemDitolak![index]['lat'];
          final String _longitude = _listItemDitolak![index]['lng'];
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemDitolakScreen(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                noteditolak: _noteditolak,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDitolakScreen(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    tglpublish: _tglpublish,
                    noteditolak: _noteditolak,
                    latitude: _latitude,
                    longitude: _longitude,
                  )));
                },
              )
          );
        },
      )
          :
      Container()
          :
      Container(),
    );
  }
}
