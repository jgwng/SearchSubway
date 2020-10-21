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
  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  } // 화면이 pop될때 같이 해제를 시켜주어야 함

  @override
  Widget build(BuildContext context) {

    String word = "강낭";
    var wordArray = splitLetter(word);
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
                  });
                },
              ),
            ],
            ),
            SizedBox(height: 300,),
            Text(array.toString()),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
