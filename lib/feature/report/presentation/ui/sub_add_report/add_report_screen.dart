import 'package:flutter/material.dart';

import '../sub_my_report/list_myreport_screen.dart';

class AddReportSreen extends StatefulWidget {
  const AddReportSreen({Key? key}) : super(key: key);

  @override
  _AddReportSreenState createState() => _AddReportSreenState();
}

class _AddReportSreenState extends State<AddReportSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Report"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 170,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 100, right: 100, top: 15, bottom: 15),
              child: OutlinedButton(
                onPressed: (){},
                child: Icon(Icons.add_a_photo_outlined, color: Colors.black, size: 30,),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Colors.blue.shade100),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            width: double.infinity,
            height: 230,
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Detail Report", style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: "Input Detail Report",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            width: double.infinity,
            height: 110,
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 20, top: 10, bottom: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Location", style: TextStyle(fontSize: 20)),
                ),
                Expanded(
                  child: Text(""),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, right: 25),
            width: double.infinity,
            height: 60,
            child: MaterialButton(
              color: Colors.blue,
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ListMyReportScreen(idtab: 1,))
                );
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.blue,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.center,
                child: Text("Publish",
                    style: TextStyle(fontSize: 17, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
