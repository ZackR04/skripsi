import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class DetailDitolakScreen extends StatefulWidget {

  final Image? gambar;
  final String? deskripsireport;
  final String? tglpublish;
  final String? noteditolak;
  final String? latitude;
  final String? longitude;

  const DetailDitolakScreen({Key? key,
  this.gambar,
  this.deskripsireport,
  this.tglpublish,
  this.noteditolak,
  this.latitude,
  this.longitude}) : super(key: key);

  @override
  _DetailDitolakScreenState createState() => _DetailDitolakScreenState();
}

class _DetailDitolakScreenState extends State<DetailDitolakScreen> {

  String alamat = '';
  String lat = '';
  String lng = '';
  bool showLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Ditolak!",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(widget.noteditolak!, style: TextStyle(fontSize: 17)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child:  Text("Tanggal Publish ${widget.tglpublish}", style: TextStyle(color: Colors.grey),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
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
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(alamat),
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
                      ],
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
