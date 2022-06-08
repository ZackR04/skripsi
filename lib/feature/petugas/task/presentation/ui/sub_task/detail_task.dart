import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/update_task_form.dart';

class DetailTaskScreen extends StatefulWidget {

  final Image? gambar;
  final String? detailreport;
  final String? tglpublish;
  final String? latitude;
  final String? longitude;
  final String? id;

  const DetailTaskScreen({Key? key,
    this.gambar,
    this.detailreport,
    this.tglpublish,
    this.latitude,
    this.longitude,
    this.id}) : super(key: key);

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {

  var dio = Dio();
  var _listDetailTask = [];
  var prefs;

  StepperType _type = StepperType.vertical;
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
  }

  void _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _getDataTask();
  }

  void _getDataTask() async {
    var formData = FormData.fromMap({
      'id_report': widget.id,
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiTask/get_task_by_idreport',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listDetailTask = jsonDecode(response.data);
      });
    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: widget.gambar,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Tanggal Publish ${widget.tglpublish!}', style: TextStyle(color: Colors.black38)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Detail Report", style: TextStyle(fontSize: 18)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(widget.detailreport!, style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Lokasi", style: TextStyle(fontSize: 18)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Latitude : ${widget.latitude}"),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Longitude : ${widget.longitude}"),
                          ),
                        ],
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Expanded(
                      child: _listDetailTask.isEmpty ? Container() : buildStepper(context)
                  ),
                ],
              )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.post_add),
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdateTaskForm())
          );
        },
      ),
    );
  }

  Widget buildStepper(BuildContext context) {
    return EnhanceStepper(
        type: _type,
        currentStep: _index,
        physics: ClampingScrollPhysics(),
        steps: _listDetailTask.map((e) =>
            EnhanceStep(
                icon: Icon(
                  _index == _listDetailTask.indexOf(e) ? Icons.check_circle_outline : Icons.adjust_rounded,
                  color: _index == _listDetailTask.indexOf(e) ? Colors.blue : Colors.grey,
                ),
                isActive: _index == _listDetailTask.indexOf(e),
                title: Text("${_listDetailTask[_listDetailTask.indexOf(e)]['tgl_update']}"),
                content: Row(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${_listDetailTask[_listDetailTask.indexOf(e)]['detail_update']}. ", textAlign: TextAlign.left)
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => taskDialog(
                          _listDetailTask[_listDetailTask.indexOf(e)]['img'],
                          _listDetailTask[_listDetailTask.indexOf(e)]['tgl_update'],
                          _listDetailTask[_listDetailTask.indexOf(e)]['detail_update'],
                          _listDetailTask[_listDetailTask.indexOf(e)]['lat'],
                          _listDetailTask[_listDetailTask.indexOf(e)]['lng'])
                        );
                      },
                      child: Text("See Details", style: TextStyle(color: Colors.blue),),
                    )
                  ],
                )
            )
        ).toList(),
        // onStepCancel: () {
        //   back();
        // },
        // onStepContinue: () {
        //
        //   next();
        // },
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container();
          //   Container(
          //   padding: EdgeInsets.only(top: 30),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 30,
          //       ),
          //       _index < _listDetailTask.length-1
          //           ?
          //       TextButton(
          //         onPressed: details.onStepContinue,
          //         child: Text("Next"),
          //       )
          //           :
          //       SizedBox(
          //         width: 8,
          //       ),
          //       _index == 0
          //           ?
          //       Container()
          //           :
          //       TextButton(
          //         onPressed: details.onStepCancel,
          //         child: Text("Back", style: TextStyle(color: Colors.red),),
          //       ),
          //     ],
          //   ),
          // );
        }
        );
  }

  // void back() {
  //   if (_index < _listDetailTask.length-1) {
  //     setState(() {
  //       _index++;
  //     });
  //     return;
  //   }
  // }
  //
  // void next() {
  //   if (_index < _listDetailTask.length-1) {
  //     setState(() {
  //       _index++;
  //     });
  //     return;
  //   }
  // }

  Widget taskDialog(String img, String tgl_update, String detail_update, String latitude, String longitude) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                options: CarouselOptions(),
                items: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_tasks/$img', fit: BoxFit.cover, width: 900)
                    ),
                  )
                ]
              ),
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Tanggal Update $tgl_update", style: TextStyle(color: Colors.black38)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Detail Update", style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("$detail_update.", style: TextStyle(fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Lokasi", style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Latitude : $latitude"),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Longitude : $longitude"),
                      ),
                    ],
                  )
              ),
          ]),
      ),
    );
  }

  // final List<Widget> imageSliders = imgList
  //     .map((item) => Container(
  //   child: Container(
  //     margin: EdgeInsets.all(5.0),
  //     child: ClipRRect(
  //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //         child: Stack(
  //           children: <Widget>[
  //             Image.network(item, fit: BoxFit.cover, width: 1000.0),
  //             Positioned(
  //               bottom: 0.0,
  //               left: 0.0,
  //               right: 0.0,
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       Color.fromARGB(200, 0, 0, 0),
  //                       Color.fromARGB(0, 0, 0, 0)
  //                     ],
  //                     begin: Alignment.bottomCenter,
  //                     end: Alignment.topCenter,
  //                   ),
  //                 ),
  //                 padding: EdgeInsets.symmetric(
  //                     vertical: 10.0, horizontal: 20.0),
  //                 child: Text(
  //                   'No Image',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 20.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )),
  //   ),
  // ))
  //     .toList();
}
