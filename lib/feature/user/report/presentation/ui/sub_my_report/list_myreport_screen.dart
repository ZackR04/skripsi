import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  final List _listItemDiproses = [];

  final List _listItemSelesai = [];

  final List _listItemDitolak = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    var formData = FormData.fromMap({
      'id_user': 2,
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
          final Image _image = Image.asset('assets/${_listItemDitinjau![index]['img']}');
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
                latitude: _latitude,
                longitude: _longitude,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDitinjauScreen(
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
      ListView.builder(
        itemCount: _listItemDiproses.length,
        itemBuilder: (context, int index){
          final Image _image = Image.asset(_listItemDiproses[index]['gambar']);
          final String _detailreport = _listItemDiproses[index]['detailreport'];
          final String _tglpublish = _listItemDiproses[index]['tgl_publish'];
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemListReportScreen(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailReportScreen(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    tglpublish: _tglpublish,
                  )));
                },
              )
          );
        },
      )
          :
      widget.idtab == 3
          ?
      ListView.builder(
        itemCount: _listItemSelesai.length,
        itemBuilder: (context, int index){
          final Image _image = Image.asset(_listItemSelesai[index]['gambar']);
          final String _detailreport = _listItemSelesai[index]['detailreport'];
          final String _tglpublish = _listItemSelesai[index]['tgl_publish'];
          final double _rating = _listItemSelesai[index]['rating'];
          print('check double : $_rating');
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemSelesaiScreen(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                rating: _rating,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSelesaiScreen(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    tglpublish: _tglpublish,
                    rating: _rating,
                  )));
                },
              )
          );
        },
      )
          :
      widget.idtab == 4
          ?
      ListView.builder(
        itemCount: _listItemDitolak.length,
        itemBuilder: (context, int index){
          final Image _image = Image.asset(_listItemDitolak[index]['gambar']);
          final String _detailreport = _listItemDitolak[index]['detailreport'];
          final String _tglpublish = _listItemDitolak[index]['tgl_publish'];
          final String _noteditolak = _listItemDitolak[index]['noteditolak'];
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
                  )));
                },
              )
          );
        },
      )
          :
      Container(),
    );
  }
}
