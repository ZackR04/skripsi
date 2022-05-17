import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailDitolakScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? waktureport;
  final String? noteditolak;

  const DetailDitolakScreen({Key? key, this.gambar, this.deskripsireport, this.waktureport, this.noteditolak})
      : super(key: key);

  @override
  _DetailDitolakScreenState createState() => _DetailDitolakScreenState();
}

class _DetailDitolakScreenState extends State<DetailDitolakScreen> {

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
                      child: Text("Ditolak!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Text(
                        widget.noteditolak!,
                        style: TextStyle(fontSize: 17)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
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
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
