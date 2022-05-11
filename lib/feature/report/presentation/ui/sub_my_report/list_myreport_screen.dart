import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_ditinjau/ui/detail_ditinjau_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_ditolak/ui/detail_ditolak_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_ditolak/ui/item_ditolak_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_selesai/ui/detail_selesai_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_selesai/ui/item_selesai_screen.dart';

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

  List _listItemDitinjau = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'tgl_publish' : '9 May 2022',
      'latitude' : '-7.7946271',
      'longitude' : '110.3925474'
    },
    {
      'id' : 1,
      'gambar' : 'assets/logo.png',
      'detailreport' : 'Saran. perlunya polisi tidur di area taman dikarenakan banyaknya anak-anak berlalu-lalang',
      'tgl_publish' : '9 May 2022',
      'latitude' : '-7.7946271',
      'longitude' : '110.3925474'
    }
  ];

  List _listItemDiproses = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'tgl_publish' : '9 May 2022',
    }
  ];

  List _listItemSelesai = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'tgl_publish' : '9 May 2022',
      'rating' : 2.0,
    }
  ];

  List _listItemDitolak = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'noteditolak' : 'Report anda ditolak dikarenakan alasan yang tidak kuat',
      'tgl_publish' : '9 May 2022',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      height: double.infinity,
      child: widget.idtab == 1
          ?
      ListView.builder(
        itemCount: _listItemDitinjau.length,
        itemBuilder: (context, int index){
          final Image _image = Image.asset(_listItemDitinjau[index]['gambar']);
          final String _detailreport = _listItemDitinjau[index]['detailreport'];
          final String _tglpublish = _listItemDitinjau[index]['tgl_publish'];
          final String _latitude = _listItemDitinjau[index]['latitude'];
          final String _longitude = _listItemDitinjau[index]['longitude'];
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
