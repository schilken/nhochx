import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_model.dart';
import 'line_chart_filled.dart';

class ChartScreen extends StatefulWidget {
  final AppModel appModel;

  ChartScreen(this.appModel);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  TextEditingController _textEditingController = TextEditingController();
  bool debounceActive = false;

  @override
  void initState() {
    _textEditingController.addListener(() async {
      if (debounceActive) return null;
      debounceActive = true;
      await Future.delayed(Duration(seconds: 2));
      debounceActive = false;
      widget.appModel.updateValues(_textEditingController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.appModel.values;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sars-COV-2 Hessen"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Infected persons in Hessen, Germany since 28.2.2020",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(height: 500, child: LineChartFilled()),
            Row(
              children: <Widget>[
                WebLink(
                linkLabel:
                    "Data Source: soziales.hessen.de/gesundheit/infektionsschutz (german)",
                url:
                    "https://soziales.hessen.de/gesundheit/infektionsschutz/coronavirus-sars-cov-2/taegliche-uebersicht-der-bestaetigten-sars-cov-2-faelle-hessen"),
                WebLink(
                  linkLabel: "Impressum",
                  url: "http://w3y.de/impressum.html",
                ),
                WebLink(
                  linkLabel: "Created with Flutter Web Beta",
                  url: "https://flutter.dev/web",
                ),
              ],
            ),
            
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                ),
                showCursor: true,
                controller: _textEditingController,
                maxLines: null,
                autofocus: true,
                //cursorWidth: 4,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            
          ],
        ),
      ),
    );
  }
}

class WebLink extends StatelessWidget {
  final String url;
  final String linkLabel;
  const WebLink({
    this.linkLabel,
    this.url,
  });

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          linkLabel,
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
