import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class XYValue {
  double x;
  double y;

  XYValue({this.x, this.y});
}

class AppModel extends ChangeNotifier {

  AppModel() {
    print("AppModel created");
  }
  String _valuesAsSingleString;

  Future<void> loadAsset() async {
    _valuesAsSingleString =
        await rootBundle.loadString('assets/data_values.txt');
    //print("loadAsset $_valuesAsSingleString");
  }

  String get values => _valuesAsSingleString;

  updateValues(String newValues) {
    //print("updateValues $newValues");
    _valuesAsSingleString = newValues;
    notifyListeners();
  }

  List<XYValue> get xyValues {
    List<XYValue> values1 = [];
    var lines = _valuesAsSingleString.split('\n');
    for (var line in lines) {
      RegExp regex = RegExp(r' *([0-9]+) *: *([0-9]+) *$', multiLine: false);
      if (regex.hasMatch(line)) {
        String xValue = regex.firstMatch(line).group(1);
        String yValue = regex.firstMatch(line).group(2);
        var x = double.parse(xValue);
        var y = double.parse(yValue);
//        print("x: $x y: $y");
        values1.add(XYValue(x: x, y: y));
      }
    }
    if (values1.isEmpty) {
      values1.add(XYValue(x: 0, y: 0));
    }
    return values1;
  }

  Future<String> readFromClipboard() async {
    //_valuesAsSingleString = await FlutterClipboardManager.copyFromClipBoard();
    var clipboardData = await Clipboard.getData('text/plain');
    _valuesAsSingleString = clipboardData.text;
    //print("readFromClipboard $_valuesAsSingleString");
    notifyListeners();
    return _valuesAsSingleString;
  }

  Future<void> writeToClipboard() async {
    //print("writeToClipboard $_valuesAsSingleString");
    var clipboardData = ClipboardData(text: _valuesAsSingleString);
    await Clipboard.setData(clipboardData);
  }
}
