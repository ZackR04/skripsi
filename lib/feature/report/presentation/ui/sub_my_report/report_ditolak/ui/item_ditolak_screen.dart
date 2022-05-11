import 'package:flutter/material.dart';

class ItemDitolakScreen extends StatefulWidget {

  final Image gambar;
  final String detailreport;
  final String tglpublish;
  final String noteditolak;
  final Function()? onclick;

  const ItemDitolakScreen
      ({Key? key,
        required this.gambar,
        required this.detailreport,
        required this.tglpublish,
        required this.noteditolak,
        this.onclick,}) : super(key: key);

  @override
  _ItemDitolakScreenState createState() => _ItemDitolakScreenState();
}

class _ItemDitolakScreenState extends State<ItemDitolakScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onclick,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 20, top: 15, bottom: 15),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade100),
        child: Row(
          children: [
            Container(
                alignment: Alignment.topLeft,
                width: 180,
                height: 170,
                child: widget.gambar
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Ditolak",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(fontSize: 15.0),
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: widget.detailreport
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(widget.tglpublish,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
