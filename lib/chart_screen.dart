import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'chart_radar.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: 600,
                child: ChartRadar())),
          ],
        );
    
  }

}