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
  var listArray = ["강낭", "당랑", "망방", "상장", "앙장", "창장"];
  bool isFocused = false;

  List<String> stations = List<String>();
  List<String> stationsForDisplay = List<String>();

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
    searchWordNode.addListener(_printLatestValue);
    super.initState();
  }

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    wordController..text = "";
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
                    padding: EdgeInsets.only(left: 20),
                    child: SearchBar(
                      controller: wordController,
                      focusNode: searchWordNode,
                    )),

//                Expanded(
//                  child: ListView.builder(
//                    itemCount: stationsForDisplay.length,
//                    shrinkWrap: false,
//                    itemBuilder: (context,index){
//                      return _listItem(index);
//                    },
//                  ),
//                ),
                Text(array.toString()),
                SizedBox(
                  height: 10,
                ),
                Text(resultArray.toString()),
              ],
            ),
          ),
        )); // This trailing comma makes auto-formatting nicer for build methods.
  }
  _printLatestValue() {
    print("Second text field: ${wordController.text}");
  }

  _listItem(index) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color.fromRGBO(238, 238, 238, 1),width:1),
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 31,top: 25.5,bottom:25.5),
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
          if (equalizer(item[j], listChanged[i][j])) {
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
  Future<List<String>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    array = splitLetter(search);
    stationsForDisplay = compareArray(array, listResultArray,listArray);
  }







}
