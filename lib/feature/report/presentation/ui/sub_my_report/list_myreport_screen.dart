import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_ditinjau/ui/detail_ditinjau_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_ditolak/ui/detail_ditolak_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_ditolak/ui/item_ditolak_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_selesai/ui/detail_selesai_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_selesai/ui/item_selesai_screen.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_report/detail_report.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_report/item_list_report.dart';

class ListMyReportScreen extends StatefulWidget {

  final int idtab;

  const ListMyReportScreen({Key? key,
    required this.idtab})
      : super(key: key);

  @override
  _ListMyReportScreenState createState() => _ListMyReportScreenState();
}

class _ListMyReportScreenState extends State<ListMyReportScreen> {

  List _listItemDitinjau = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'waktureport' : 'Kemarin',
    },
    {
      'id' : 1,
      'gambar' : 'assets/logo.png',
      'detailreport' : 'Saran. perlunya polisi tidur di area taman dikarenakan banyaknya anak-anak berlalu-lalang',
      'waktureport' : '2 Hari lalu',
    }
  ];

  List _listItemDiproses = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'waktureport' : 'Kemarin',
    }
  ];

  List _listItemSelesai = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'waktureport' : 7,
      'rating' : 2.0,
    }
  ];

  List _listItemDitolak = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'waktureport' : 'Kemarin',
      'noteditolak' : 'Report anda ditolak dikarenakan alasan yang tidak kuat',
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
          final String _waktureport = _listItemDitinjau[index]['waktureport'];
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemListReportScreen(
                gambar: _image,
                detailreport: _detailreport,
                waktureport: _waktureport,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDitinjauScreen(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    waktureport: _waktureport,
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
          final String _waktureport = _listItemDiproses[index]['waktureport'];
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemListReportScreen(
                gambar: _image,
                detailreport: _detailreport,
                waktureport: _waktureport,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailReportScreen(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    waktureport: _waktureport,
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
          final int _waktureport = _listItemSelesai[index]['waktureport'];
          final double _rating = _listItemSelesai[index]['rating'];
          print('check double : $_rating');
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemSelesaiScreen(
                gambar: _image,
                detailreport: _detailreport,
                waktureport: _waktureport,
                rating: _rating,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSelesaiScreen(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    waktureport: _waktureport,
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
          final String _waktureport = _listItemDitolak[index]['waktureport'];
          final String _noteditolak = _listItemDitolak[index]['noteditolak'];
          return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemDitolakScreen(
                gambar: _image,
                detailreport: _detailreport,
                waktureport: _waktureport,
                noteditolak: _noteditolak,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDitolakScreen(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    waktureport: _waktureport,
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