import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/user/contact_service/presentation/ui/list_contact_service.dart';

class MenuContactServiceScreen extends StatefulWidget {
  @override
  _MenuContactServiceScreenState createState() => _MenuContactServiceScreenState();
}

class _MenuContactServiceScreenState extends State<MenuContactServiceScreen> {

  List _listContactService = [
    {
      'id' : 0,
      'image' : 'assets/cleaning_services.png',
      'title' : 'Cleaning Service',
    },
    {
      'id' : 1,
      'image' : 'assets/faucet.png',
      'title' : 'Saluran Air & Pipa',
    },
    {
      'id' : 2,
      'image' : 'assets/serv_bangun.png',
      'title' : 'Service Bangunan',
    },
    {
      'id' : 3,
      'image' : 'assets/listrik.png',
      'title' : 'Perbaikan Listrik',
    },
    {
      'id' : 4,
      'image' : 'assets/tukang_kebun.png',
      'title' : 'Tukang Kebun',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Info Kontak Service"),
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30),
            child: ListView.builder(
              itemCount: _listContactService.length,
              itemBuilder: (context, int index){
                return _itemContactService(
                    _listContactService[index]['id'],
                    _listContactService[index]['image'],
                    _listContactService[index]['title']);
              },
            )
        ),
      ),
    );
  }

  Widget _itemContactService(int id, String gambar, String title) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 60,
      child: MaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ListContactServiceScreen(
                title: title,
                idContact: id,
              )));
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blue,
            width: 1,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10)),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Image.asset(
                gambar,
                color: Colors.indigo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
