import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_history_task/list_historytask.dart';
import 'package:skripsi_residencereport/feature/petugas/task/presentation/ui/sub_task/list_task.dart';

class HomeScreenPet extends StatefulWidget {
  const HomeScreenPet({Key? key}) : super(key: key);

  @override
  _HomeScreenPetState createState() => _HomeScreenPetState();
}

class _HomeScreenPetState extends State<HomeScreenPet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                        icon: Image.asset('assets/task.png'),
                        iconSize: 150,
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => TaskScreen())
                          );
                        },
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Task",
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              Text("Task adalah menu untuk mengupdate pekerjaan/task terkait kendala di perumahan yang sudah diberikan kepada petugas.",
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
                              Text("History Task",
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              Text("History Task adalah menu yang menampilkan pekerjaan-pekerjaan perumahan yang sudah diselesaikan petugas.",
                                style: TextStyle(color: Colors.black54),
                                textAlign: TextAlign.start,),
                            ],
                          )
                      ),
                      IconButton(
                        icon: Image.asset('assets/historytask.png'),
                        iconSize: 150,
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => HistoryTaskScreen())
                          );
                        },
                      )
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
    );
  }
}
