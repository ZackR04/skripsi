import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_report',
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
        child: ListView.builder(
          itemCount: _listItemReport!.length,
          itemBuilder: (context, int index){
            final Image _image = Image.asset(_listItemReport![index]['gambar']);
            final String _detailreport = _listItemReport![index]['detailreport'];
            final String _tglpublish = _listItemReport![index]['tglpublish'];
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
