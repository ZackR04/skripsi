import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InboxScreen extends StatefulWidget {

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {

  var dio = Dio();
  var _listPaketUser;
  var prefs;

  // 'username' : 'Zakiah',
  // 'no_resi' : 'TKP00021290908',
  // 'nama_penerima' : 'Fandi Sujatmiko',
  // 'no_handphone' : '081260006443',
  // 'alamat' : 'Perumahan Graha Indah Blok 3 No.24',
  // 'pengirim' : 'Grand Royale Petshop',
  // 'jasa_pengiriman' : "SiCepat"

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
  }

  void _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _getDataPaket();
  }

  void _getDataPaket() async {
    var formData = FormData.fromMap({
      'id_user': prefs.getString('id'),
    });
    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiTask/get_task_by_idreport',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listPaketUser = jsonDecode(response.data);
      });
      print(_listPaketUser);
    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Inbox"),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 100,
              padding: EdgeInsets.only(top: 5, bottom:5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text("11 Maret",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Container(
            margin: EdgeInsets.only(left:10, right: 50),
            // padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )
                    ),
                    padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                    child: _buildInbox(
                        _listPaketUser[0]['username'],
                        _listPaketUser[0]['no_resi']
                    )),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.info_outline, size: 35,),
                                                  Padding(padding: EdgeInsets.only(left: 5)),
                                                  Text("Informasi Paket Anda", style:
                                                  TextStyle(fontSize: 15)),
                                                ],
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 20),),
                                              Row(
                                                children: [
                                                  Text("No. Resi", style:
                                                  TextStyle(fontSize: 15)),
                                                  Padding(padding: EdgeInsets.only(left: 5)),
                                                  Text(_listPaketUser[0]['no_resi'],
                                                    style: TextStyle(color: Colors.blue, fontSize: 15),),
                                                ],
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 7),),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Nama Penerima",
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 5)),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(_listPaketUser[0]['nama_penerima'],
                                                  style: TextStyle(color: Colors.blue, fontSize: 15),),
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 7),),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("No. Handphone",
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 5)),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(_listPaketUser[0]['no_handphone'],
                                                  style: TextStyle(color: Colors.blue, fontSize: 15),),
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 7),),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Alamat",
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 5)),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(_listPaketUser[0]['alamat'],
                                                  style: TextStyle(color: Colors.blue, fontSize: 15),),
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 7),),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Pengirim",
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 5)),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(_listPaketUser[0]['pengirim'],
                                                  style: TextStyle(color: Colors.blue, fontSize: 15),),
                                              ),
                                              Padding(padding: EdgeInsets.only(top: 7),),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Jasa Pengiriman",
                                                    style: TextStyle(fontSize: 15)),
                                              ),
                                              Padding(padding: EdgeInsets.only(left: 5)),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(_listPaketUser[0]['jasa_pengiriman'],
                                                  style: TextStyle(color: Colors.blue, fontSize: 15),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      );
                    },
                    child: Text("Selengkapnya tentang paket anda",
                      style: TextStyle(
                          color: Colors.blue
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInbox(String username, String noResi) {
    return Text("Hai ${username}, paket anda dengan nomor resi ${noResi} telah sampai di pos kami. Silahkan ambil dan tunjukkan pesan ini kepada petugas kami. Terimakasih");
  }
}
