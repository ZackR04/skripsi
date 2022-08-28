import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_add_report/add_report_screen.dart';
import 'package:skripsi_residencereport/feature/user/report/presentation/ui/sub_my_report/my_report_screen.dart';
import 'sub_report/list_report.dart';
import 'package:steps_indicator/steps_indicator.dart';

class MenuReportScreen extends StatefulWidget {
  @override
  _MenuReportScreenState createState() => _MenuReportScreenState();
}

class _MenuReportScreenState extends State<MenuReportScreen> {

  int selectedStep = 0;
  int nbSteps = 4;

  List _listKeteranganReport = [
    {
      'id' : 0,
      'title' : 'Step Pertama',
      'deskripsi' : 'Klik Icon + kemudian anda akan diarahkan ke halaman selanjutnya'
    },
    {
      'id' : 1,
      'title' : 'Step Kedua',
      'deskripsi' : 'Isi Form sesuai dengan masalah yang ingin anda report, kemudian klik tombol publish maka report anda akan segera kami tinjau'
    },
    {
      'id' : 2,
      'title' : 'Step Ketiga',
      'deskripsi' : 'Jika ditolak anda dapat melihat alasan terkait di Menu My Report => Ditolak'
    },
    {
      'id' : 3,
      'title' : 'Step Keempat',
      'deskripsi' : 'Jika diterima anda dapat melihat progresnya di Menu My Report => Diproses'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Image.asset('assets/report.png'),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  height: 70,
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ListReportScreen())
                      );
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.blue,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Report",
                          style: TextStyle(fontSize: 20, color: Colors.blue)),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  height: 70,
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => MyReportScreen()));
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.blue,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("My Report",
                              style: TextStyle(fontSize: 20, color: Colors.blue)),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: FloatingActionButton(
                              child: Icon(Icons.add),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddReportScreen()));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 25)),
                Container(
                  child: Text("Tata cara melakukan Report",
                      style: TextStyle(fontSize: 17, color: Colors.black54, fontWeight: FontWeight.bold)),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                          child: _buildNotes(
                              _listKeteranganReport[0]['id'],
                              _listKeteranganReport[0]['title'],
                              _listKeteranganReport[0]['deskripsi']
                          )),
                      Padding(padding: EdgeInsets.only(left: 40)),
                      Expanded(
                          child: _buildNotes(
                              _listKeteranganReport[1]['id'],
                              _listKeteranganReport[1]['title'],
                              _listKeteranganReport[1]['deskripsi']
                          )),
                      Padding(padding: EdgeInsets.only(right: 30))
                    ],
                  ),
                ),
                StepsIndicator(
                  selectedStep: selectedStep,
                  nbSteps: nbSteps,
                  doneLineColor: Colors.grey,
                  doneStepColor: Colors.grey,
                  undoneLineColor: Colors.grey,
                  unselectedStepColorIn: Colors.grey,
                  unselectedStepColorOut: Colors.grey,
                  selectedStepSize: 20,
                  lineLength: 80,
                  enableLineAnimation: true,
                  enableStepAnimation: true,
                ),
                Padding(padding: EdgeInsets.only(top: 25)),
                Container(
                  height: 120,
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40)),
                      Expanded(
                          child: _buildNotes(
                              _listKeteranganReport[2]['id'],
                              _listKeteranganReport[2]['title'],
                              _listKeteranganReport[2]['deskripsi']
                          )),
                      Padding(padding: EdgeInsets.only(left: 40)),
                      Expanded(
                          child: _buildNotes(
                              _listKeteranganReport[3]['id'],
                              _listKeteranganReport[3]['title'],
                              _listKeteranganReport[3]['deskripsi']
                          )),
                    ],
                  ),
                ),
                _buildNextPrevButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotes(int index, String title, String deskripsi) {
    return Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: index == selectedStep? 16:15,
                      fontWeight: FontWeight.bold,
                      color: index == selectedStep? Colors.blueAccent:Colors.black54)),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  deskripsi,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: index == selectedStep? FontWeight.bold:FontWeight.normal,
                  )
                ),
              )
            ],
          )
        ],
    );
  }

  Widget _buildNextPrevButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: (){
            if(selectedStep > 0){
              setState(() {
                selectedStep--;
              });
              print('Number ${selectedStep}');
            }
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back, size: 20, color: Colors.red,),
              Text('Prev', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        MaterialButton(
          onPressed: (){
            if(selectedStep < (nbSteps-1)){
              setState(() {
                selectedStep++;
              });
              print('Number ${selectedStep}');
            }
          },
          child: Row(
            children: [
              Text('Next', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward, size: 20, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }
}
