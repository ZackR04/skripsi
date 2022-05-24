import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/detail_task.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/item_list_task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  List _listItemTask = [
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
        title: Text("Task"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        height: double.infinity,
        child: ListView.builder(
          itemCount: _listItemTask.length,
          itemBuilder: (context, int index){
            final Image _image = Image.asset(_listItemTask[index]['gambar']);
            final String _detailreport = _listItemTask[index]['detailreport'];
            final String _tglpublish = _listItemTask[index]['tglpublish'];
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemListTask(
                gambar: _image,
                detailreport: _detailreport,
                tglpublish: _tglpublish,
                onclick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTaskScreen(
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
