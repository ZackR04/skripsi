import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_history_task/detail_historytask.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_history_task/item_historytask.dart';

class HistoryTaskScreen extends StatefulWidget {
  const HistoryTaskScreen({Key? key}) : super(key: key);

  @override
  _HistoryTaskScreenState createState() => _HistoryTaskScreenState();
}

class _HistoryTaskScreenState extends State<HistoryTaskScreen> {

  var dio = Dio();
  List? _listItemHistoryTask;
  var prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
  }

  void _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _getHistoryTask();
  }

  void _getHistoryTask() async {
    var formData = FormData.fromMap({
      'id_petugas': prefs.getString('id'),
      'status_report': 4,
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_report_for_petugas',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemHistoryTask = jsonDecode(response.data);
      });
      print(_listItemHistoryTask);
    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History Task"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        height: double.infinity,
        child: _listItemHistoryTask != null
            ?
        ListView.builder(
          itemCount: _listItemHistoryTask!.length,
          itemBuilder: (context, int index){
            final String _id = _listItemHistoryTask![index]['id'];
            final Image _image = Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_reports/'+_listItemHistoryTask![index]['img']);
            final String _detailreport = _listItemHistoryTask![index]['deskripsi'];
            final String _tglpublish = _listItemHistoryTask![index]['tanggal_dibuat'];
            final String _latitude = _listItemHistoryTask![index]['lat'];
            final String _longitude = _listItemHistoryTask![index]['lng'];
            final double _rating = _listItemHistoryTask![index]['rating'];
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemHistoryTask(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                rating: _rating,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailHistoryTask(
                    id: _id,
                    gambar: _image,
                    detailreport: _detailreport,
                    tglpublish: _tglpublish,
                    latitude: _latitude,
                    longitude: _longitude,
                    rating: _rating,
                  )));
                },
              ),
            );
          },
        )
            :
        Container(),
      ),
    );
  }
}
