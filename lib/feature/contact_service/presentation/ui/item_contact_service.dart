import 'package:flutter/material.dart';

class ItemContactServiceScreen extends StatefulWidget {

  final String title;
  final String deskripsi;
  final String no_contact;

  const ItemContactServiceScreen(
      {Key? key,
        required this.title,
        required this.deskripsi,
        required this.no_contact})
      : super(key: key);

  @override
  _ItemContactServiceScreenState createState() => _ItemContactServiceScreenState();
}

class _ItemContactServiceScreenState extends State<ItemContactServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 20, top: 10, bottom: 5),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Expanded(
                  child: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text: widget.deskripsi,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Icon(Icons.call, color: Colors.black38, size: 17),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text("${widget.no_contact}",
                        style: TextStyle(color: Colors.black45),)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  onPressed: () {},
                  child: Text("Hubungi"),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                      width: 0.5,
                      style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
