import 'package:covd19/ui/colors.dart';
import 'package:flutter/material.dart';
import 'sceensize.dart';
import 'package:covd19/charts/wave_progress.dart';
import 'package:covd19/service/service_locator.dart';
import 'package:covd19/service/call_service.dart';
import 'package:covd19/service/newsmodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsUi extends StatefulWidget {
  @override
  _NewsUiState createState() => _NewsUiState();
}

class _NewsUiState extends State<NewsUi> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  var jsondata;
  var cases;
  var now = new DateTime.now();
  Updated d;
  String s = "https://indiacovid-api.herokuapp.com/updates";
  Future<void> getData() async {
    final response = await http.get(s);
    jsondata = json.decode(response.body);
    d = Updated.fromJson(jsondata);
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
        title: Text(
          "UPDATES",
          style: TextStyle(color: Colors.white),
        ),
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
                children: d.news
                    .map(
                      (pointer) => Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 30,
                        ),
                        child: Column(
                          children: <Widget>[
                            vaweCard(
                              context,
                              pointer.date,
                              pointer.news,
                              pointer.links,
                              Colors.grey.shade100,
                              Color(0xFF3CB371),
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

  Widget vaweCard(BuildContext context, String name, String fields, String url,
      Color fillColor, Color bgColor) {
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
                95,
              ),
              IconButton(
                icon: Icon(Icons.wb_iridescent),
                color: Colors.white,
                onPressed: () => _service.launchUrl(url),
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: screenAwareSize(200, context),
                child: Text(
                  fields,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
