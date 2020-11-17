import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:seperatekorean/model/subway_arrival.dart';



const String _urlPrefix = "http://swopenapi.seoul.go.kr/api/subway/";
const String _userKey = '5046634a75776a643935506c5a4667';
const String _urlSuffix = '/json/realtimeStationArrival/0/5/';
const int STATUS_OK = 200;



class SubwayArrivalPage extends StatefulWidget{
  SubwayArrivalPage({this.stationName});
  final String stationName;


  @override
  SubwayArrivalPageState createState() => SubwayArrivalPageState();
}

class SubwayArrivalPageState extends State<SubwayArrivalPage>{

  int _rowNum;
  String _subwayId;
  String _trainLineNm;
  String _subwayHeading;
  String _arvlMsg2;


  String _response = '';

  String _buildUrl(String station){
    StringBuffer sb = StringBuffer();
    sb.write(_urlPrefix);
    sb.write(_userKey);
    sb.write(_urlSuffix);
    sb.write(widget.stationName);
    return sb.toString();
  }
  _httpGet(String url) async {
    var response = await http.get(_buildUrl(widget.stationName));
    String res = response.body;
    print('res>>$res');

    var json = jsonDecode(res);
    Map<String, dynamic> errorMessage = json['errorMessage'];

    if(errorMessage['status'] != STATUS_OK){
    setState(() {
      final String errMessage = errorMessage['message'];
      _rowNum = -1;
      _subwayId = '';
      _trainLineNm = '';
      _subwayHeading = '';
      _arvlMsg2 = errMessage;
    });
    return;
  }
    List<dynamic> realtimeArrivalList = json['realtimeArrivalList'];
    final int cnt = realtimeArrivalList.length;

    List<SubwayArrival> list = List.generate(cnt,(int i){
      Map<String,dynamic> item = realtimeArrivalList[i];
      return SubwayArrival(
          item['rowNum'],
          item['subwayId'],
          item['trainLineNm'],
          item['subwayHeading'],
          item['arvlMsg2']
      );
    });


   SubwayArrival first = list[0];

   setState(() {
     _rowNum = first.rowNum;
     _subwayId = first.subwayId;
     _trainLineNm = first.trainLineNm;
     _subwayHeading = first.subwayHeading;
     _arvlMsg2 = first.arvlMsg2;
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
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('rowNum ; $_rowNum'),
              Text('_subwayId ; $_subwayId'),
              Text('_trainLineNm ; $_trainLineNm'),
              Text('_subwayHeading ; $_subwayHeading'),
              Text('_arvlMsg2 ; $_arvlMsg2'),
            ],
          )
      ),
    );
  }

}
