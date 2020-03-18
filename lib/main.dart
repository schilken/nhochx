import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'chart_screen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppModel _appModel = AppModel();
    await _appModel.loadAsset();
    runApp(
    ChangeNotifierProvider<AppModel>.value(
      value: _appModel,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: false);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChartScreen(appModel),
    );
  }
}