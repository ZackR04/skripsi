import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_history_task/detail_historytask.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_history_task/item_historytask.dart';

class HistoryTaskScreen extends StatefulWidget {
  const HistoryTaskScreen({Key? key}) : super(key: key);

  @override
  _HistoryTaskScreenState createState() => _HistoryTaskScreenState();
}

class _HistoryTaskScreenState extends State<HistoryTaskScreen> {

  var dio = Dio();

  List _listItemHistoryTask = [];

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
        child: ListView.builder(
          itemCount: _listItemHistoryTask.length,
          itemBuilder: (context, int index){
            final Image _image = Image.asset(_listItemHistoryTask[index]['gambar']);
            final String _detailreport = _listItemHistoryTask[index]['detailreport'];
            final String _tglpublish = _listItemHistoryTask[index]['tglpublish'];
            final double _rating = _listItemHistoryTask[index]['rating'];
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemHistoryTask(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                rating: _rating,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailHistoryTask(
                    gambar: _image,
                    deskripsireport: _detailreport,
                    tglpublish: _tglpublish,
                    rating: _rating,
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
