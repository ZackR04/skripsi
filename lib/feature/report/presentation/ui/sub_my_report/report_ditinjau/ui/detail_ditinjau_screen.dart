import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/report/presentation/ui/sub_my_report/report_ditinjau/ui/form_editreport.dart';

class DetailDitinjauScreen extends StatefulWidget {
  final Image? gambar;
  final String? deskripsireport;
  final String? waktureport;
  final String? tglpublish;
  final String? latitude;
  final String? longitude;

  const DetailDitinjauScreen(
      {Key? key,
      this.gambar,
      this.deskripsireport,
      this.waktureport,
      this.tglpublish,
      this.latitude,
      this.longitude,})
      : super(key: key);

  @override
  _DetailDitinjauScreenState createState() => _DetailDitinjauScreenState();
}

class _DetailDitinjauScreenState extends State<DetailDitinjauScreen> {
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
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.blue.shade100),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Ditinjau!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.blue.shade100),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text("Report anda dalam peninjauan",
                        style: TextStyle(fontSize: 17)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Tanggal Publish"),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                            ),
                            Text("${widget.tglpublish}"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:Text(
                              "Lokasi",
                              style: TextStyle(fontSize: 20),
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        ),
                        Row(
                          children: [
                            Text("Latitude : "),
                            Text("${widget.latitude}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Longitude"),
                            Text("${widget.longitude}"),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Detail Report",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.deskripsireport!,
                          style: TextStyle(fontSize: 15),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => EditReportScreen(
                                  deskripsireport: widget.deskripsireport,
                                ))
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline_outlined),
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: RaisedButton(
                  //     onPressed: () async{
                  //       Prediction p = await PlacesAutocomplete.show(
                  //           context: context, apiKey: kGoogleApiKey);
                  //       displayPrediction(p);
                  //     },
                  //     child: Text("Find Address"),
                  //   ),
                  // ),
                ],
              )),
        ),
      ),
    );
  }
}
