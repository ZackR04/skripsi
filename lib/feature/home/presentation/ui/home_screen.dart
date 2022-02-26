import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/contact_service/presentation/ui/menu_contact_service.dart';
import '../../../report/presentation/ui/menu_report.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 50)),
                Image.asset('assets/logo.png'),
                Padding(
                    padding: EdgeInsets.only(top: 50)),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          icon: Image.asset('assets/report.png'),
                          iconSize: 150,
                          onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => MenuReportScreen())
                            );
                          },
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Report",
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              Text("Report adalah menu untuk mengirimkan report/laporan terkait kendala di perumahan kepada petugas perumahan",
                                  style: TextStyle(color: Colors.black54),
                                  textAlign: TextAlign.start,),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30)),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Info Kontak Service",
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              Text("Info Kontak Service adalah menu yang menampilkan kontak-kontak service perumahan yang berguna untuk penduduk",
                                style: TextStyle(color: Colors.black54),
                                textAlign: TextAlign.start,),
                            ],
                          )
                      ),
                      IconButton(
                        icon: Image.asset('assets/cs.png'),
                        iconSize: 150,
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => MenuContactServiceScreen())
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: (){
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => InboxScreen())
          // );
        },
      )
    );
  }
}
