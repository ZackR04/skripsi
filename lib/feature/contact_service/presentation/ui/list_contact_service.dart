import 'package:flutter/material.dart';
import 'package:skripsi_residencereport/feature/contact_service/presentation/ui/item_contact_service.dart';

class ListContactServiceScreen extends StatefulWidget {

  final int? idContact;
  final String? title;

  const ListContactServiceScreen({Key? key, this.idContact, this.title})
      : super(key: key);

  @override
  _ListContactServiceScreenState createState() => _ListContactServiceScreenState();
}

class _ListContactServiceScreenState extends State<ListContactServiceScreen> {

  List _listItemContactService = [
    {
      'id' : 0,
      'namaperusahaan' : 'PT. Bersih Jaya',
      'detailperusahaan' : 'Berlokasi di jalan Patimura No.23 perusahaan ini sudah berdiri sejak tahun 2012 dan melayani banyak pelanggan dengan...',
      'nocontact' : '081260006443'
    },
    {
      'id' : 1,
      'namaperusahaan' : 'PT. Rapi Jaya',
      'detailperusahaan' : 'Berlokasi di jalan Patimura No.23 perusahaan ini sudah berdiri sejak tahun 2012 dan melayani banyak pelanggan dengan...',
      'nocontact' : '082164436000'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 15),
        height: double.infinity,
        child: ListView.builder(
          itemCount: _listItemContactService.length,
          itemBuilder: (context, int index){
            final String _perusahaanname = _listItemContactService[index]['namaperusahaan'];
            final String _perusahaandetail = _listItemContactService[index]['detailperusahaan'];
            final String _contactid = _listItemContactService[index]['nocontact'];
            return Padding(
              padding: EdgeInsets.only(top: 15),
              child: ItemContactServiceScreen(
                title: _perusahaanname,
                deskripsi: _perusahaandetail,
                no_contact: _contactid,
              ),
            );
          },
        ),
      ),
    );
  }
}
