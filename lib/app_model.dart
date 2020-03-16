import 'package:flutter/material.dart';

class XYValue {
  double x;
  double y;

  XYValue({this.x, this.y});
}

class AppModel extends ChangeNotifier {

  String _values = """
0, 1
1, 8
2, 11
5, 15
6, 17
7, 17
8, 20
9, 27
11, 48
12, 91
13, 133
14, 191
15, 282
16, 342
""";

String get values => _values;

updateValues(String newValues) {
//  print("updateValues $newValues");
  _values = values;
  notifyListeners();
}

List<XYValue> get xyValues {
  List<XYValue> values1 = []; 
    values1.add(XYValue(x: 0, y: 1));
    values1.add(XYValue(x: 1, y: 8));
    values1.add(XYValue(x: 2, y: 11));
    values1.add(XYValue(x: 5, y: 15));
    values1.add(XYValue(x: 6, y: 17));
    values1.add(XYValue(x: 7, y: 17));
    values1.add(XYValue(x: 8, y: 20));
    values1.add(XYValue(x: 9, y: 27));
    values1.add(XYValue(x: 11, y: 48));
    values1.add(XYValue(x: 12, y: 91));
    values1.add(XYValue(x: 13, y: 133));
    values1.add(XYValue(x: 14, y: 191));
    values1.add(XYValue(x: 15, y: 282));
    values1.add(XYValue(x: 16, y: 342));
    return values1;
}

// notifyListeners();
}