import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'line_chart_filled.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    _textEditingController.text = appModel.values;
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
            Text(
              "Infected in Hessen, Germany since 28.2.2020",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            Container(height: 600, child: LineChartFilled()),
            Text(
              "Data Source:\nhttps://soziales.hessen.de/gesundheit/infektionsschutz/coronavirus-sars-cov-2/taegliche-uebersicht-der-bestaetigten-sars-cov-2-faelle-hessen",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
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
            Text(
              "Impressum: http://w3y.de/impressum.html - Created with Flutter Web Beta",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
