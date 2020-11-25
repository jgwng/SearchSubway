import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:seperatekorean/screens/home_page.dart';

class OnBoarding extends StatefulWidget{
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding>{

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle.light,
       child: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topCenter,
             end : Alignment.bottomCenter,
             stops: [0.1,0.4,0.7,0.9],
             colors: [
               Color(0xFF3594DD),
               Color(0xFF4563DB),
               Color(0xFF5036D5),
               Color(0xFF5816D0),
             ]
           )
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               Container(
                 padding: EdgeInsets.only(right: 10,top: 20),
                 alignment: Alignment.bottomRight,
                 child: FlatButton(
                 onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
                     MyHomePage(title: '지하철 검색',))),
                 child: Text('Skip',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20
                 ),),
               ),),
               Text("초성만으로도 검색이 가능합니다!",
                   textAlign: TextAlign.center,
                   style:TextStyle(
                 fontSize:20,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "NotoSans"
               )),
               SizedBox(height: 20,),
               Container(
                 height: 605,
                 padding : EdgeInsets.symmetric(horizontal: 24),
                 child:Image.asset("assets/image/AppScreenShot.png",fit: BoxFit.cover,),
               )
             ],
         ),
       ),
     ),
   );
  }

}