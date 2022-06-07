import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/detail_task.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/item_list_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  var dio = Dio();
  List? _listItemTask;
  var prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
  }

  void _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _getDataReportTask();
  }

  void _getDataReportTask() async {
    var formData = FormData.fromMap({
      'id_petugas': prefs.getString('id'),
    });
    final response = await dio.post(
      'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiReport/get_report_for_petugas',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemTask = jsonDecode(response.data);
      });
      print(_listItemTask);
    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        height: double.infinity,
        child: _listItemTask != null
            ?
        ListView.builder(
          itemCount: _listItemTask!.length,
          itemBuilder: (context, int index){
            final String _id = _listItemTask![index]['id'];
            final Image _image = Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_reports/'+_listItemTask![index]['img']);
            final String _detailreport = _listItemTask![index]['deskripsi'];
            final String _tglpublish = _listItemTask![index]['tanggal_dibuat'];
            final String _latitude = _listItemTask![index]['lat'];
            final String _longitude = _listItemTask![index]['lng'];
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemListTask(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTaskScreen(
                    id: _id,
                    gambar: _image,
                    detailreport: _detailreport,
                    tglpublish: _tglpublish,
                    latitude: _latitude,
                    longitude: _longitude,
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
