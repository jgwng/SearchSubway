import 'package:flutter/material.dart';
import 'package:seperatekorean/const_of_hangul.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final titleController = TextEditingController();
  var array=[];
  var resultArray =[];
  var listArray= ["강낭","당랑","망방","상장","앙장","창장"];

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    titleController..text = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
            children: [
              Container(
                width: 300,
                child: TextField(
                  controller: titleController,
                ),
              ),
              RaisedButton(
                child: Text("변환"),
                onPressed: (){
                  setState(() {
                    String word = titleController.text;
                    array = splitLetter(word);
                    resultArray = aa(array, listArray);
                  });
                },
              ),
            ],
            ),
            SizedBox(height: 300,),
            Text(array.toString()),
            SizedBox(height: 10,),
            Text(resultArray.toString()),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  List<dynamic> aa(var item, var list){
    int index = 0;
    int counter = item.length;
    for(int i =0;i<counter;i++){
      if(item[i].length ==1){
        if(item[i] == list[i][0]){
          index++;
        }
      }


    }




    return resultArray;
  }


}



