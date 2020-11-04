import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'show ByteData, rootBundle;
import 'package:seperatekorean/Debouncer.dart';
import 'package:seperatekorean/const_of_hangul.dart';
import 'package:seperatekorean/search_bar.dart';
import 'package:collection/collection.dart';

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

  final Debouncer onSearchDebouncer = Debouncer(delay: Duration(milliseconds: 500));

  void _onFocusChange() async {
    setState(() {
      isFocused = !isFocused;
    });
  }

  @override
  void initState() {
    aaa();
    searchWordNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }

  void onChange(String text) async{

    setState(() {
      array = splitLetter(text);

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
          title: Text(widget.title),
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
                      suffixIconOnTab: aaa,
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: stationsForDisplay.length,
                    shrinkWrap: false,
                    itemBuilder: (context,index){
                      return _listItem(index);
                    },
                  ),
                ),

              ],
            ),
          ),
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }

  aaa() async {
    ByteData data = await rootBundle.load("assets/subway_stations_name.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes,);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);
      for (var row in excel.tables[table].rows.sublist(1,excel.tables[table].rows.length)) {
        stations.add(row[2]);
      }
    }

    stationsForDisplay = stations;
    for (int i = 0; i < stationsForDisplay.length; i++) {
      var wordResult = splitLetter(stationsForDisplay[i]);
      listResultArray.add(wordResult);
    }
    print(listResultArray);

  }


  _listItem(index) {
    return GestureDetector(
      onTap: (){
          print(stationsForDisplay[0]);
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
              stationsForDisplay[index],
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
          )),
    );
  }

  List<dynamic> compareArray(var item, var listChanged,var list) {
    int index = 0;
    int counter = item.length;
    resultArray = [];
    Function equalizer = const ListEquality().equals;
    for (int i = 0; i < listChanged.length; i++) {
      for (int j = 0; j < counter; j++) {
        if (item[j].length == 1) {
          if (item[j] == listChanged[i][j][0]) {
            index++;
          }
        } else {
          if(item[j][2] ==""){
            if((item[j][0]==listChanged[i][j][0])&&(item[j][1]==listChanged[i][j][1])){
              index++;
              print('a');
            }
          }
          else if (equalizer(item[j], listChanged[i][j])) {
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








}
