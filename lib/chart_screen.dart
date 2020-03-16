import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'line_chart_filled.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            )),
      ],
    );
  }
}
