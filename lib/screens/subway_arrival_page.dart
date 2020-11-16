import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class SubwayArrival extends StatefulWidget{
  SubwayArrival({this.stationName});
  final String stationName;


  @override
  SubwayArrivalState createState() => SubwayArrivalState();
}

class SubwayArrivalState extends State<SubwayArrival>{
  static const String _urlPrefix = "http://swopenapi.seoul.go.kr/api/subway/";
  static const String _userKey = '5046634a75776a643935506c5a4667';
  static const String _urlSuffix = '/json/realtimeStationArrival/0/5/';


  String _response = '';

  String _buildUrl(String station){
    StringBuffer sb = StringBuffer();
    sb.write(_urlPrefix);
    sb.write(_userKey);
    sb.write(_urlSuffix);
    sb.write(widget.stationName);
    return sb.toString();
  }
  _httpGet(String url) async{
    var response = await http.get(_buildUrl(widget.stationName));
    String res = response.body;
    print('res>>$res');
    setState((){
      _response = res;
    });
  }

  @override
  void initState(){
    super.initState();
    _httpGet(_buildUrl(widget.stationName));
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('지하철 실시간 정보'),
      ),
      body: Center(
          child:Text(_response)
      ),
    );
  }

}
