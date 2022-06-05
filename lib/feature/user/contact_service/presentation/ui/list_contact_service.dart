import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi_residencereport/feature/user/contact_service/presentation/ui/item_contact_service.dart';

class ListContactServiceScreen extends StatefulWidget {

  final int? idContact;
  final String? title;

  const ListContactServiceScreen({Key? key, this.idContact, this.title})
      : super(key: key);

  @override
  _ListContactServiceScreenState createState() => _ListContactServiceScreenState();
}

class _ListContactServiceScreenState extends State<ListContactServiceScreen> {

  var dio = Dio();
  List? _listItemContactService;
  var prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
  }

  void _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _getItemContactService();
  }

  void _getItemContactService() async {

    var formData = FormData.fromMap({
      'id_bidang': widget.idContact,
    });

    final response = await dio.post(
        'http://www.zafa-invitation.com/dashboard/backend-skripsi/index.php/rest_api/ApiInfoContactService/get_info_contact_service',
        data: formData
    );
    if(response.statusCode == 200){
      setState(() {
        _listItemContactService = jsonDecode(response.data);
      });
      print(_listItemContactService);
    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 15),
        height: double.infinity,
        child: _listItemContactService != null ? ListView.builder(
          itemCount: _listItemContactService!.length,
          itemBuilder: (context, int index){
            final String _perusahaanname = _listItemContactService![index]['nama_perusahaan'];
            final String _perusahaandetail = _listItemContactService![index]['detail_perusahaan'];
            final String _contactid = _listItemContactService![index]['no_hp'];
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemContactServiceScreen(
                title: _perusahaanname,
                deskripsi: _perusahaandetail,
                no_contact: _contactid,
              ),
            );
          },
        ) : Container(),
      ),
    );
  }
}
