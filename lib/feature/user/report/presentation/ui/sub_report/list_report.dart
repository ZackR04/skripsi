import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_report/detail_report.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_report/item_list_report.dart';

class ListReportScreen extends StatefulWidget {
  @override
  _ListReportScreenState createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {

  List _listItemReport = [
    {
      'id' : 0,
      'gambar' : 'assets/report.png',
      'detailreport' : 'Aspal didepan rumah Blok C berlubang, saya rasa kerusakannya sudah sangat menggangu aktivitas warga',
      'tglpublish' : '10 Januari 2015',
    },
    {
      'id' : 1,
      'gambar' : 'assets/logo.png',
      'detailreport' : 'Saran. perlunya polisi tidur di area taman dikarenakan banyaknya anak-anak berlalu-lalang',
      'tglpublish' : '12 Mei 2016',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        height: double.infinity,
        child: ListView.builder(
          itemCount: _listItemReport.length,
          itemBuilder: (context, int index){
            final Image _image = Image.asset(_listItemReport[index]['gambar']);
            final String _detailreport = _listItemReport[index]['detailreport'];
            final String _tglpublish = _listItemReport[index]['tglpublish'];
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
              ),
            );
          },
        ),
      ),
    );
  }
}
