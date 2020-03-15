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
                children: <Widget>[
                  Text("Infizierte in Hessen seit 28.2.2020",
                  style: TextStyle(
                    fontSize: 24,
                  ),),
                  Container(
                    height: 600,
                    child: LineChartFilled()),
                ],
              )),
          ],
        );
    
  }

}