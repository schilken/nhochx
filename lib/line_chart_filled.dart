import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:mp_chart/mp/controller/line_chart_controller.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart/mp/core/data_provider/line_data_provider.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/enums/axis_dependency.dart';
import 'package:mp_chart/mp/core/fill_formatter/i_fill_formatter.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';
import 'package:mp_chart/mp/core/value_formatter/value_formatter.dart';

class Formatter extends ValueFormatter {
  NumberFormat _format;

  Formatter() : super() {
    _format = NumberFormat("######");
  }

  @override
  String getFormattedValue1(double value) {
    return _format.format(value);
  }
}

class LineChartFilled extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LineChartFilledState();
  }
}

class LineChartFilledState extends State<LineChartFilled> {
  LineChartController _controller;
  ValueFormatter _valueFormatter = Formatter();
  var random = Random(1);
  int _count = 20;
  double _range = 300.0;

  @override
  void initState() {
    _initController();
    _initLineData(_count, _range);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 0,
          child: LineChart(_controller),
        ),
        
      ],
    );
  }

  void _initController() {

    var desc = Description()
    ..enabled = false
    ..text = "ok";
    _controller = LineChartController(
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            //..setAxisMaximum(400)
            ..setAxisMinimum(0)
            ..drawAxisLine = (true)
            ..setDrawZeroLine(true)
            ..drawGridLines = (true);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = (false);
        },
        legendSettingFunction: (legend, controller) {
          legend.enabled = (false);
          var formatter1 = (controller as LineChartController)
              .data
              .getDataSetByIndex(0)
              .getFillFormatter();
          if (formatter1 is A) {
            formatter1.setPainter(controller);
          }
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis.enabled = (true);
          xAxis..drawGridLines = (true);
          xAxis.setLabelCount1(15);
        },
        drawBorders: true,
        drawGridBackground: true,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        //gridBackColor: _fillColor,
        backgroundColor: ColorUtils.WHITE,
        description: desc);
        _controller.animator
      ..reset()
      ..animateX1(5000);
  }

  void _initLineData(int count, double range) {
    List<Entry> values1 = new List();

    values1.add(new Entry(x: 0, y: 1));
    values1.add(new Entry(x: 1, y: 8));
    values1.add(new Entry(x: 2, y: 11));
    values1.add(new Entry(x: 5, y: 15));
    values1.add(new Entry(x: 6, y: 17));
    values1.add(new Entry(x: 7, y: 17));
    values1.add(new Entry(x: 8, y: 20));
    values1.add(new Entry(x: 9, y: 27));
    values1.add(new Entry(x: 11, y: 48));
    values1.add(new Entry(x: 12, y: 91));
    values1.add(new Entry(x: 13, y: 133));
    values1.add(new Entry(x: 14, y: 191));
    values1.add(new Entry(x: 15, y: 282));
    values1.add(new Entry(x: 16, y: 342));
    
   LineDataSet set1; 

    // create a dataset and give it a type
    set1 = new LineDataSet(values1, "DataSet 1");

    set1.setAxisDependency(AxisDependency.LEFT);
    set1.setColor1(Color.fromARGB(255, 255, 241, 46));
    set1.setDrawCircles(true);
    set1.setLineWidth(2);
    set1.setCircleRadius(3);
    set1.setFillAlpha(255);
    set1.setDrawFilled(true);
    set1.setFillColor(ColorUtils.RED);
    set1.setHighLightColor(Color.fromARGB(255, 244, 117, 117));
    set1.setDrawCircleHole(true);
    set1.setFillFormatter(A());
   
    // create a data object with the data sets
    _controller.data = LineData.fromList(List()..add(set1));
    
    _controller.data.setDrawValues(true);
    _controller.data.setValueTextSize(20);
    _controller.data.setValueTextColor(ColorUtils.RED);
    _controller.data.setValueFormatter(_valueFormatter);

    setState(() {});
  }

  //Color _fillColor = Color.fromARGB(150, 51, 181, 229);

}

class A implements IFillFormatter {
  LineChartController _controller;

  void setPainter(LineChartController controller) {
    _controller = controller;
  }

  @override
  double getFillLinePosition(
      ILineDataSet dataSet, LineDataProvider dataProvider) {
    return _controller?.painter?.axisLeft?.axisMinimum;
  }
}

