import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/update_task_form.dart';

class DetailTaskScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? tglpublish;

  const DetailTaskScreen({Key? key, this.gambar, this.deskripsireport, this.tglpublish}) : super(key: key);

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
                        color: Colors.blue.shade100
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          widget.tglpublish!,
                          style: TextStyle(
                              color: Colors.black38)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text(
                        widget.deskripsireport!,
                        style: TextStyle(fontSize: 16)),
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
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("${_listDetailTask[_listDetailTask.indexOf(e)]['deskripsi']}", textAlign: TextAlign.left)
                      ),
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
}
