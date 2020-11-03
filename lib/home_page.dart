import 'package:flutter/material.dart';
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
  var listArray = ["강낭","강상", "당랑", "망방", "상장", "앙장", "창장"];
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

    stations = listArray;
    stationsForDisplay = listArray;
    for (int i = 0; i < listArray.length; i++) {
      var wordResult = splitLetter(listArray[i]);
      listResultArray.add(wordResult);
    }
    searchWordNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }

  void onChange(String text){
    setState(() {
//      array = splitLetter(text);
//      stationsForDisplay = compareArray(array, listResultArray,listArray);
//      print(stationsForDisplay);
//      array = splitLetter(text);
//
//      stationsForDisplay = compareArray(array, listResultArray,listArray);
      array = splitLetter(text);
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


  _listItem(index) {
    return GestureDetector(
      onTap: (){

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
          if(item[i][2]==""){
            if((item[i][0]==listChanged[i][j][0]) &&(item[i][0]==listChanged[i][j][0]) ){
              index++;
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
  Future<List<dynamic>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    array = splitLetter(search);
    stationsForDisplay = compareArray(array, listResultArray,listArray);
  }







}
