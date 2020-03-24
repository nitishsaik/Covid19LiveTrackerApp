import 'package:flutter/material.dart';
import 'sceensize.dart';
import 'dart:convert';
import 'package:covd19/charts/wave_progress.dart';
import 'package:http/http.dart' as http;
import 'package:covd19/service/getdata.dart';
import 'package:covd19/ui/colors.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  var jsondata;
  var cases;
  var now = new DateTime.now();
  CoronaDetails d;
  String s = "https://api-corona.herokuapp.com/total";
  Future<void> getData() async {
    final response = await http.get(s);
    jsondata = json.decode(response.body);
    d = CoronaDetails.fromJson(jsondata);
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
                children: d.main
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
                                "COVID-19",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  inherit: true,
                                  color: Colors.white,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                colorCard("Total Cases", pointer.coronaCases,
                                    context, Color(0xFF765d69)),
                                colorCard("Total Deaths", pointer.coronaDeaths,
                                    context, Color(0xFFab6ca2)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                colorCard("Total Recoverd", pointer.recoverd,
                                    context, Color(0xFF475c78))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Active Cases",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                inherit: true,
                                letterSpacing: 0.4,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            vaweCard(
                                context,
                                "Currently Infected Patients",
                                pointer.coronaCurrent,
                                pointer.coronaCurrent,
                                Colors.greenAccent,
                                Color(0xFF765d69)),
                            vaweCard(
                              context,
                              "in Mild Condition",
                              pointer.coronaMild,
                              pointer.coronaCurrent,
                              Colors.greenAccent,
                              Color(0xFFff596b),
                            ),
                            vaweCard(
                                context,
                                "Serious/Critical",
                                pointer.coronaCritical,
                                pointer.coronaCurrent,
                                Colors.grey.shade100,
                                Color(0xFF765d69)),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "CLOSED CASES",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                inherit: true,
                                letterSpacing: 0.4,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            vaweCard(
                              context,
                              "Cases which had an outcome",
                              pointer.coronaClose,
                              pointer.coronaClose,
                              Colors.grey.shade100,
                              Color(0xFF716cff),
                            ),
                            vaweCard(
                              context,
                              "Recovered / Discharged",
                              pointer.coronaDischarged,
                              pointer.coronaClose,
                              Colors.grey.shade100,
                              Color(0xFFff596b),
                            ),
                            vaweCard(
                              context,
                              "Deaths",
                              pointer.coronaDeaths,
                              pointer.coronaClose,
                              Colors.grey.shade100,
                              Color(0xFFff596b),
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
    String a = f.replaceAll(RegExp(','), '');
    String b = total.replaceAll(RegExp(','), '');
    double c = (((double.parse(a).ceil() / double.parse(b).ceil())) * 100);
    String x = c.toStringAsFixed(2);

    return Container(
      margin: EdgeInsets.only(
        top: 15,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15),
      height: screenAwareSize(80, context),
      decoration: BoxDecoration(
        color: Bgcolor,
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
                "${x.toString()}",
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
