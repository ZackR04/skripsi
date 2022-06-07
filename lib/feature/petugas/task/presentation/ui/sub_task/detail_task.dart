import 'package:carousel_slider/carousel_slider.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/update_task_form.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class DetailTaskScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? tglpublish;
  final String? latitude;
  final String? longitude;
  final String? id;

  const DetailTaskScreen({Key? key,
    this.gambar,
    this.deskripsireport,
    this.tglpublish,
    this.latitude,
    this.longitude,
    this.id}) : super(key: key);

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {

  final List _listDetailTask = [
    {
      'icon' : Icons.check_circle_outline,
      'title_activity' : 'Activity 1',
      'subtitle_activity' : 'sub activity 1',
      'deskripsi' : 'Deskripsi Activity Satu'
    },
    {
      'icon' : Icons.check_circle_outline,
      'title_activity' : 'Activity 2',
      'subtitle_activity' : 'sub activity 2',
      'deskripsi' : 'Deskripsi Activity Dua'
    },
    {
      'icon' : Icons.check_circle_outline,
      'title_activity' : 'Activity 3',
      'subtitle_activity' : 'sub activity 3',
      'deskripsi' : 'Deskripsi Activity Tiga'
    },
    {
      'icon' : Icons.check_circle_outline,
      'title_activity' : 'Activity 4',
      'subtitle_activity' : 'sub activity 4',
      'deskripsi' : 'Deskripsi Activity Empat'
    },
    {
      'icon' : Icons.check_circle_outline,
      'title_activity' : 'Activity 5',
      'subtitle_activity' : 'sub activity 5',
      'deskripsi' : 'Deskripsi Activity Lima'
    },
  ];

  StepperType _type = StepperType.vertical;
  int _index = 0;

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
                          child: Text('Tanggal Publish${widget.tglpublish!}', style: TextStyle(color: Colors.black38)),
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
                          child: Text(
                              widget.deskripsireport!,
                              style: TextStyle(fontSize: 16)),
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
                      child: buildStepper(context)
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
                  _index == _listDetailTask.indexOf(e) ? _listDetailTask[_listDetailTask.indexOf(e)]['icon'] : Icons.adjust_rounded,
                  color: _index == _listDetailTask.indexOf(e) ? Colors.blue : Colors.grey,
                ),
                isActive: _index == _listDetailTask.indexOf(e),
                title: Text("${_listDetailTask[_listDetailTask.indexOf(e)]['title_activity']}"),
                subtitle: Text("${_listDetailTask[_listDetailTask.indexOf(e)]['subtitle_activity']}"),
                content: Row(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${_listDetailTask[_listDetailTask.indexOf(e)]['deskripsi']}. ", textAlign: TextAlign.left)
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => imageDialog()
                        );
                      },
                      child: Text("See Details", style: TextStyle(color: Colors.blue),),
                    )
                  ],
                )
            )
        ).toList(),
        onStepCancel: () {
          back();
        },
        onStepContinue: () {

          next();
        },
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                ),
                _index < _listDetailTask.length-1
                    ?
                TextButton(
                  onPressed: details.onStepContinue,
                  child: Text("Next"),
                )
                    :
                SizedBox(
                  width: 8,
                ),
                _index == 0
                    ?
                Container()
                    :
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text("Back", style: TextStyle(color: Colors.red),),
                ),
              ],
            ),
          );
        });
  }

  void back() {
    if (_index < _listDetailTask.length-1) {
      setState(() {
        _index++;
      });
      return;
    }
  }

  void next() {
    if (_index < _listDetailTask.length-1) {
      setState(() {
        _index++;
      });
      return;
    }
  }

  Widget imageDialog() {
    return Dialog(
      child: CarouselSlider(
        options: CarouselOptions(),
        items: imgList.map((item) => Container(
          child: Center(
              child: Image.network(item, fit: BoxFit.cover, width: 900)
          ),
        )).toList(),
      ),
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ),
  ))
      .toList();
}
