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
  FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController.addListener(() async {
      if (debounceActive) return null;
      debounceActive = true;
      await Future.delayed(Duration(seconds: 2));
      debounceActive = false;
      widget.appModel.updateValues(_textEditingController.text);
    });
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.appModel.values;

    return Scaffold(
      appBar: AppBar(
        title: Text("SARS-CoV-2 Hessen, Germany"),
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
                "Infected persons in Hessen*, Germany since 28.2.2020",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Container(height: 500, child: LineChartFilled()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("* Population of Hessen: 6.3 million"),
                ),
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
                WebLink(
                  linkLabel: "Source on Github",
                  url: "https://github.com/schilken/nhochx",
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 300,
              width: 400,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 110,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                      ),
                      showCursor: true,
                      controller: _textEditingController,
                      maxLines: null,
                      autofocus: true,
                      focusNode: _focusNode,
                      //cursorWidth: 4,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {
                          _textEditingController.text = '';
                          _focusNode.requestFocus();
                        },
                        child: Text("Clear Data"),
                      ),
                      OutlineButton(
                        onPressed: () async => _textEditingController.text =
                            await widget.appModel.readFromClipboard(),
                        child: Text("Read Data from Clipboard"),
                      ),
                      OutlineButton(
                        onPressed: () async =>
                            widget.appModel.writeToClipboard(),
                        child: Text("Write Data to Clipboard"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Edit your data outside\nand read it from clipboard"),
                      ),
                      Text(
                        "The buttons don't work with mobile browser (yet).",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "You can paste directly into the field.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
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
