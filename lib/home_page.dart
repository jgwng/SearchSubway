import 'package:flutter/material.dart';
import 'package:seperatekorean/const_of_hangul.dart';
import 'package:seperatekorean/search_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final wordController = TextEditingController();

  var array=[];
  var resultArray =[];
  var listArray= ["강낭","당랑","망방","상장","앙장","창장"];
  bool isFocused = false;

  FocusNode searchWordNode = FocusNode();
  void _onFocusChange() async{
    setState(() {
      isFocused =!isFocused;

    });
  }

  @override
  void initState() {
    super.initState();
    searchWordNode.addListener(_onFocusChange);
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
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 300,
                  child: SearchBar(controller: wordController,)
              ),
              RaisedButton(
                child: Text("변환"),
                onPressed: (){
                  setState(() {
                    String word = wordController.text;
                    array = splitLetter(word);

                    resultArray = compareArray(array, listArray);
                  });
                },
              ),
              SizedBox(height: 300,),
              Text(array.toString()),
              SizedBox(height: 10,),
              Text(resultArray.toString()),
            ],
          ),

        ),
      )
      );// This trailing comma makes auto-formatting nicer for build methods.
  }

  List<dynamic> compareArray(var item, var list){
    int index = 0;
    int counter = item.length;

    for(int i =0;i<list.length;i++){
      for(int j=0;j<counter;j++){
        if(item[j].length ==1){
          if(item[j] == list[i][0]){
            index++;
          }
        } else{
          if(item[j] == list[j]){
            index++;
          }
        }
      }

      if(index == counter){
        resultArray.add(list[i]);
      }
    }
    return resultArray;
  }


}



