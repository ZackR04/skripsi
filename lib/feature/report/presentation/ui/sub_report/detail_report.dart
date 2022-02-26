import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

class DetailReportScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? waktureport;

  const DetailReportScreen({Key? key, this.gambar, this.deskripsireport, this.waktureport})
      : super(key: key);

  @override
  _DetailReportScreenState createState() => _DetailReportScreenState();
}

class _DetailReportScreenState extends State<DetailReportScreen> {

  List _listDetailReport = [
    {
      'id' : 0,
      'report' : 'Report Diterima',
    },
    {
      'id' : 1,
      'report' : 'Petugas mulai memperbaiki jalan',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 250,
                  child: widget.gambar,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        widget.waktureport!,
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
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Detail Maintenance",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5d5e5e))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                             Expanded(
                               child: Align(
                                 alignment: Alignment.topLeft,
                                 child: StepsIndicator(
                                   selectedStep: 0,
                                   nbSteps: 5,
                                   doneLineColor: Colors.grey,
                                   doneStepColor: Colors.grey,
                                   undoneLineColor: Colors.grey,
                                   unselectedStepColorIn: Colors.grey,
                                   unselectedStepColorOut: Colors.grey,
                                   selectedStepSize: 15,
                                   lineLength: 60,
                                   enableLineAnimation: true,
                                   enableStepAnimation: true,
                                   isHorizontal: false,
                                 ),
                               ),
                             ),
                              Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _listDetailReport.length,
                                    itemBuilder: (context, int index){
                                      return Container(
                                        child: Text(_listDetailReport[index]['report']),
                                      );
                                    },
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  Widget _reportNotes(int index, String report) {
    return Text(
        report,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54),
    );
  }
}
