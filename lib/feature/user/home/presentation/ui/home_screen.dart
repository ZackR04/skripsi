import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/user/contact_service/presentation/ui/menu_contact_service.dart';
import '../../../inbox/presentation/ui/inbox_screen.dart';
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
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Column(
            children: [
              Image.asset('assets/logo.png'),
              Padding(
                  padding: EdgeInsets.only(top: 40)),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        icon: Image.asset('assets/report.png'),
                        iconSize: 150,
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => MenuReportScreen())
                          );
                        },
                      ),
                    ),
                    Expanded(
                        child: ListView(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 25)),
                            Text("Report",
                                style: TextStyle(fontSize: 25)),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10)),
                            Text("Report adalah menu untuk mengirimkan report/laporan terkait kendala di perumahan kepada petugas perumahan",
                              style: TextStyle(color: Colors.black54),
                              textAlign: TextAlign.start,),
                          ],
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text("Report",
                        //         style: TextStyle(fontSize: 25)),
                        //     Padding(
                        //         padding: EdgeInsets.only(bottom: 10)),
                        //     Text("Report adalah menu untuk mengirimkan report/laporan terkait kendala di perumahan kepada petugas perumahan",
                        //       style: TextStyle(color: Colors.black54),
                        //       textAlign: TextAlign.start,),
                        //   ],
                        // )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: ListView(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("Info Kontak Service",
                              style: TextStyle(fontSize: 25),
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10)),
                            Text("Info Kontak Service adalah menu yang menampilkan kontak-kontak service perumahan yang berguna untuk penduduk",
                              style: TextStyle(color: Colors.black54),
                              textAlign: TextAlign.start,),
                          ],
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text("Info Kontak Service",
                        //       style: TextStyle(fontSize: 25),
                        //     ),
                        //     Padding(
                        //         padding: EdgeInsets.only(bottom: 10)),
                        //     Text("Info Kontak Service adalah menu yang menampilkan kontak-kontak service perumahan yang berguna untuk penduduk",
                        //       style: TextStyle(color: Colors.black54),
                        //       textAlign: TextAlign.start,),
                        //   ],
                        // )
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        icon: Image.asset('assets/cs.png'),
                        iconSize: 150,
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => MenuContactServiceScreen())
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: MaterialButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                  },
                  child:  Row(
                    children: [
                      Icon(Icons.logout),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Text("Logout"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InboxScreen())
          );
        },
      )
    );
  }
}
