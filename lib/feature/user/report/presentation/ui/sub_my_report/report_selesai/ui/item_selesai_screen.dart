import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ItemSelesaiScreen extends StatefulWidget {

  final Image gambar;
  final String detailreport;
  final String tglpublish;
  final double rating;
  final Function()? onclick;

  const ItemSelesaiScreen({Key? key,
  required this.gambar,
  required this.detailreport,
  required this.tglpublish,
  required this.rating,
  required this.onclick,}) : super(key: key);

  @override
  _ItemSelesaiScreenState createState() => _ItemSelesaiScreenState();
}

class _ItemSelesaiScreenState extends State<ItemSelesaiScreen> {
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
                      child: RatingStars(
                        value: widget.rating,
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                        starCount: 5,
                        starSize: 20,
                        starSpacing: 2,
                        valueLabelVisibility: false,
                        starColor: Colors.yellow,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
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
