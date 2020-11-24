import 'package:flutter/material.dart';
import 'package:seperatekorean/screens/home_page.dart';
import 'package:seperatekorean/screens/onBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _isFirst;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirst  = prefs.getBool('isFirst') ?? true;
  if(isFirst){
    prefs.setBool('isFirst',false);
  }
  _isFirst = isFirst;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var activity;
    if(_isFirst){
      activity = OnBoarding();
      setFirst();
    }else{
      activity = MyHomePage(title: '지하철 검색');
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:activity,
    );
  }

  setFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirst',false);
  }
}

