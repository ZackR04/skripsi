import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_history_task/detail_historytask.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_history_task/item_historytask.dart';

class HistoryTaskScreen extends StatefulWidget {
  const HistoryTaskScreen({Key? key}) : super(key: key);

  @override
  _HistoryTaskScreenState createState() => _HistoryTaskScreenState();
}

class _HistoryTaskScreenState extends State<HistoryTaskScreen> {

  final List _listItemHistoryTask = [];

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
