import 'package:covd19/service/statewise.dart';
import 'package:covd19/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:covd19/ui/sceensize.dart';

class Coronad extends StatelessWidget {
  final StateWise corona;

  Coronad({this.corona});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 90),
                  Row(
                    children: <Widget>[
                      colorCard("Confirmed IN", corona.indianNational, context,
                          Color(0xFF8fb9a8)),
                      colorCard("Confirmed FN", corona.foreignNational, context,
                          Color(0xFFf1828d)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      colorCard("Discharged", corona.discharged, context,
                          Color(0xFF765d69)),
                      colorCard(
                          "Death", corona.deaths, context, Color(0xFF685d79)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: corona.state,
                child: Container(
                  height: 140.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assests/coronadetails.png"),
                  )),
                )),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Bgcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(corona.state),
      ),
      body: bodyWidget(context),
    );
  }
}

Widget colorCard(
    String text, String fields, BuildContext context, Color color) {
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 9, right: 9),
    padding: EdgeInsets.all(25),
    height: screenAwareSize(80, context),
    width: _media.width / 2 - 25,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "${fields.toString()}",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}
