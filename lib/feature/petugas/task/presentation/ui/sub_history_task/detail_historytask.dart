import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailHistoryTask extends StatefulWidget {

  final Image? gambar;
  final String? detailreport;
  final String? tglpublish;
  final String? latitude;
  final String? longitude;
  final String? id;
  final double rating;

  const DetailHistoryTask({Key? key,
    this.gambar,
    this.detailreport,
    this.tglpublish,
    this.latitude,
    this.longitude,
    this.id,
    required this.rating,}) : super(key: key);

  @override
  _DetailHistoryTaskState createState() => _DetailHistoryTaskState();
}

class _DetailHistoryTaskState extends State<DetailHistoryTask> {

  var dio =  Dio();
  var _listDetailHistoryTask;
  var prefs;
  String sublocation = '';
  String alamat = '';
  String lat = '';
  String lng = '';
  bool showLoad = false;

  StepperType _type = StepperType.vertical;
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
    lat = widget.latitude ?? '';
    lng = widget.longitude ?? '';
    _firstlocation(lat, lng);
  }

  void _firstlocation(String lat, String lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(lat), double.parse(lng));
    setState(() {
      alamat = '${placemarks.first.street} ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}, ${placemarks.first.postalCode}';
      showLoad = false;
    });
  }

  void _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _getDataHistoryTask();
  }

  void _getDataHistoryTask() async {
    var formData = FormData.fromMap({
      'id_report': widget.id,
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiTask/get_task_by_idreport',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listDetailHistoryTask = jsonDecode(response.data);
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
                          Center(
                            child: RatingStars(
                              value: widget.rating,
                              starBuilder: (index, color) => Icon(
                                Icons.star,
                                color: color,
                              ),
                              starCount: 5,
                              starSize: 40,
                              starSpacing: 0,
                              valueLabelVisibility: false,
                              starColor: Colors.yellow,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
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
                            child: Text(alamat),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      child: _listDetailHistoryTask == null ? Container() : buildStepper(context)
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget buildStepper(BuildContext context) {
    return EnhanceStepper(
        type: _type,
        currentStep: _index,
        physics: ClampingScrollPhysics(),
        steps: [
          for(var index=0; index<_listDetailHistoryTask.length; index++)
            EnhanceStep(
                icon: Icon(
                  _index == index ? Icons.check_circle_outline : Icons.adjust_rounded,
                  color: _index == index ? Colors.blue : Colors.grey,
                ),
                isActive: _index == index,
                title: Text("${DateFormat('dd MMM yyyy').format(DateTime.parse(_listDetailHistoryTask[index]['tgl_update']))}"),
                content: Row(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_listDetailHistoryTask[index]['detail_update'].length > 45 ? "${_listDetailHistoryTask[index]['detail_update'].substring(0, 45)}..."
                            : "${_listDetailHistoryTask[index]['detail_update']}. ", textAlign: TextAlign.left)
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _sublocation(_listDetailHistoryTask[index]['lat'],
                            _listDetailHistoryTask[index]['lng']);
                        await showDialog(
                            context: context,
                            builder: (_) => historytaskDialog(
                              _listDetailHistoryTask[index]['img'],
                              _listDetailHistoryTask[index]['tgl_update'],
                              _listDetailHistoryTask[index]['detail_update'],
                              _listDetailHistoryTask[index]['lat'],
                              _listDetailHistoryTask[index]['lng'],
                            )
                        );
                      },
                      child: const Text("See Details", style: TextStyle(color: Colors.blue),),
                    )
                  ],
                )
            )
        ],


        // _listDetailHistoryTask.map((e) =>
        //     EnhanceStep(
        //         icon: Icon(
        //           _index == _listDetailHistoryTask.indexOf(e) ? Icons.check_circle_outline : Icons.adjust_rounded,
        //           color: _index == _listDetailHistoryTask.indexOf(e) ? Colors.blue : Colors.grey,
        //         ),
        //         isActive: _index == _listDetailHistoryTask.indexOf(e),
        //         title: Text("${_listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['tgl_update']}"),
        //         content: Row(
        //           children: [
        //             Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: Text("${_listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['detail_update']}. ", textAlign: TextAlign.left)
        //             ),
        //             GestureDetector(
        //               onTap: () async {
        //                 await _sublocation(_listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['lat'],
        //                     _listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['lng']);
        //                 await showDialog(
        //                     context: context,
        //                     builder: (_) => historytaskDialog(
        //                       _listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['img'],
        //                       _listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['tgl_update'],
        //                       _listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['detail_update'],
        //                       _listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['lat'],
        //                       _listDetailHistoryTask[_listDetailHistoryTask.indexOf(e)]['lng'],
        //                     )
        //                 );
        //               },
        //               child: Text("See Details", style: TextStyle(color: Colors.blue),),
        //             )
        //           ],
        //         )
        //     )
        // ).toList(),



        // onStepCancel: () {
        //   back();
        // },
        // onStepContinue: () {
        //   next();
        // },
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container();
          //   padding: EdgeInsets.only(top: 30),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 30,
          //       ),
          //       _index < _listDetailHistoryTask.length-1
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
        });
  }

  // void back() {
  //   if (_index > 0) {
  //     setState(() {
  //       _index--;
  //     });
  //     return;
  //   }
  // }
  //
  // void next() {
  //   if (_index < _listDetailHistoryTask.length-1) {
  //     setState(() {
  //       _index++;
  //     });
  //     return;
  //   }
  // }

  Widget historytaskDialog(String img, String tgl_update, String detail_update, String latitude, String longitude) {
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
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                    child: Image.network('http://www.zafa-invitation.com/dashboard/backend-skripsi/assets/img_tasks/$img', fit: BoxFit.cover, width: 900)
                ),
              ),
              // CarouselSlider(
              //     options: CarouselOptions(),
              //     items: [
              //
              //     ]
              // ),
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
                        child: Text(sublocation),
                      ),
                    ],
                  )
              ),
            ]),
      ),
    );
  }

  _sublocation(String latitude, String longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(latitude), double.parse(longitude));
    setState(() {
      sublocation = '${placemarks.first.street} ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}, ${placemarks.first.postalCode}';
    });
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
//                   'No. ${imgList.indexOf(item)} image',
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
