import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show rootBundle;
import 'package:collection/collection.dart';
import 'package:seperatekorean/consts/const_of_hangul.dart';
import 'package:seperatekorean/model/subway_station.dart';
import 'package:seperatekorean/screens/subway_arrival_page.dart';
import 'package:seperatekorean/widget/search_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final wordController = TextEditingController();
  var array = [];
  var resultArray = [];
  var listResultArray = [];
  bool isFocused = false;
  List<dynamic> stations = List<dynamic>();
  List<dynamic> stationsForDisplay = List<dynamic>();

  FocusNode searchWordNode = FocusNode();


  void _onFocusChange() async {
    setState(() {
      isFocused = !isFocused;
    });
  }

  @override
  void initState() {
//    aaa();
    searchWordNode.addListener(_onFocusChange);
    super.initState();
//    WidgetsBinding.instance.addPostFrameCallback((_) async {
//      await _getData();
//    });
    _getData().then((result){
      setState(() {
        stationsForDisplay = result;
//        print(result);
      });
    });
  }

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }

  void onChange(String text) async{

    setState(() {
      array = splitLetter(text);
      print(array);
      stationsForDisplay = compareArray(array, listResultArray,stations);
//      stationsForDisplay = compareArray(array, listResultArray,listArray);
//
//      print(compareArray(array, listResultArray,listArray));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title,style:TextStyle(
            fontSize: 15,fontFamily: "NotoSans",fontWeight: FontWeight.w500,
            color: Colors.black
          )),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width ,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: SearchBar(
                      controller: wordController,
                      focusNode: searchWordNode,
                      onChange: onChange,
                      onTap: onTap,
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: stationsForDisplay.length,
                    shrinkWrap: false,
                    itemBuilder: (context,index){
                      return _listItem(stationsForDisplay[index]);
                    },
                ),
            ),
          ])
    ),
    )
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Future<List<String>> _getData() async{
    String jsonString = await rootBundle.loadString("assets/subway_stations_name.json");
    var jsonResult = jsonDecode(jsonString)['DATA'];
    for(int i=0;i<jsonResult.length;i++){
      var json = jsonResult[i];
      var subwayStation = SubwayStation.fromJson(json);
      stations.add(subwayStation.name);
      var wordResult = splitLetter(subwayStation.name);
      listResultArray.add(wordResult);
  }
    stationsForDisplay = stations;
    return stations;
//   var user = SubwayStation.fromJson(jsonResult);
//   print(user);

  }

  Widget _listItem(String text) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            SubwayArrivalPage(stationName: text,)));
//        print(text);
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color.fromRGBO(238, 238, 238, 1),width:1),
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20,top: 20,bottom:20),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "NotoSans",
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            ),
          )),
    );
  }

  List<dynamic> compareArray(var item, var listChanged,var list) {
    int index = 0;
    int counter = item.length;
    resultArray = [];
    for (int i = 0; i < listChanged.length; i++) {
      for (int j = 0; j < counter; j++) {
        if(listChanged[i].length<item.length){
        }
        else if (item[j].length == 1) {
          if (item[j] == listChanged[i][j][0]) {
            index++;
          }
        } else {
          if(item[j][2] ==""){
            if((item[j][0]==listChanged[i][j][0])&&(item[j][1]==listChanged[i][j][1])){
              index++;
            }
          }
          else if (item[j].toString()==listChanged[i][j].toString()) {
            index++;
          }
        }
      }
      if (index == counter) {
        resultArray.add(list[i]);
      }
      index = 0;
    }
    return resultArray;
  }

  void onTap(){
    setState((){
      wordController.clear();
      stationsForDisplay = stations;

    });
  }
}



