import 'package:covd19/ui/colors.dart';
import 'package:flutter/material.dart';
import 'sceensize.dart';
import 'dart:convert';
import 'package:covd19/charts/wave_progress.dart';
import 'package:http/http.dart' as http;
import 'package:covd19/service/india.dart';
import 'package:covd19/ui/newsui.dart';

class IndiaScreen extends StatefulWidget {
  @override
  _IndiaScreenState createState() => _IndiaScreenState();
}

class _IndiaScreenState extends State<IndiaScreen> {
  var jsondata;
  var cases;
  var now = new DateTime.now();
  India d;
  String s = "https://indiacovid-api.herokuapp.com/";
  Future<void> getData() async {
    final response = await http.get(s);
    jsondata = json.decode(response.body);
    d = India.fromJson(jsondata);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Bgcolor,
      body: d == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Fgcolor),
              ),
            )
          : RefreshIndicator(
              onRefresh: getData,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: d.stats
                    .map(
                      (pointer) => Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 40,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              "INDIA COVID-19",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                colorCard("Passengers screened", pointer.screend,
                                    context, Color(0xFF8fb9a8)),
                                colorCard("Active COVID", pointer.activeIndia,
                                    context, Color(0xFFf1828d)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                colorCard("discharged casess", pointer.cured,
                                    context, Color(0xFF765d69)),
                                colorCard("Death cases", pointer.death, context,
                                    Color(0xFF685d79)),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                colorCard("Migrated Patient", pointer.migration,
                                    context, Color(0xFF475c78)),
                              ],
                            ),
                            SizedBox(height: 20),
                            MaterialButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsUi()),
                                );
                              },
                              minWidth: double.infinity,
                              height: 40,
                              child: Text(
                                "LATEST UPDATES".toUpperCase(),
                              ),
                              color: Fgcolor,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }

  Widget vaweCard(BuildContext context, String name, String f, String total,
      Color fillColor, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15),
      height: screenAwareSize(80, context),
      decoration: BoxDecoration(
        color: Fgcolor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              WaveProgress(
                screenAwareSize(45, context),
                fillColor,
                bgColor,
                67,
              ),
              Text(
                "${total.toString()}%",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${f.toString()}",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget colorCard(String text, String f, BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 18, right: 12),
      padding: EdgeInsets.all(25),
      height: screenAwareSize(100, context),
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
            "${f.toString()}",
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
}
