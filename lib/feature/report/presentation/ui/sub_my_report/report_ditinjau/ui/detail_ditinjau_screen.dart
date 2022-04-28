import 'package:flutter/material.dart';

class DetailDitinjauScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? waktureport;

  const DetailDitinjauScreen({Key? key,
  this.gambar,
  this.deskripsireport,
  this.waktureport}) : super(key: key);

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
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Ditinjau!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100
                    ),
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
                    child: Text("Lokasi",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text("Detail Report",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      widget.deskripsireport!,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text("${widget.waktureport}",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Icon(
                        Icons.edit,
                      ),
                      Icon(
                        Icons.delete_outline_outlined,
                      )
                    ],
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
              )
          ),
        ),
      ),
    );
  }
}
