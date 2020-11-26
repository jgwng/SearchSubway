import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

const f = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ',
  'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ',
  'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'];
const s = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ',
  'ㅖ', 'ㅗ', 'ㅘ', 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ',
  'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ', 'ㅣ'];
const t = ['', 'ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ',
  'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ', 'ㄼ', 'ㄽ', 'ㄾ',
  'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ',
  'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'];
const ga = 44032;


int wordToInteger(String text){
  double a = double.parse(text);
  int a_int = a.floor();
  return a_int;
}


List<dynamic> splitLetter(String text){
  List<String> wordArray = text.split("");
  var arr = List(wordArray.length);
  for(int i=0;i<wordArray.length;i++){
    var unicode = (wordArray[i]).codeUnits;
     int unicodeInt = unicode[0];
    unicodeInt = unicodeInt - ga;

    var fn = (unicodeInt/588);
    int fnInt = wordToInteger(fn.toString());


    var sn = ((unicodeInt - (fnInt * 588)) / 28);
    int snInt = wordToInteger(sn.toString());

    var tn = (unicodeInt % 28);
    int tnInt = wordToInteger(tn.toString());

    if(fn<0) arr[i] = wordArray[i];
    else{
      arr[i] = [f[fnInt],s[snInt],t[tnInt]];
    }
  }
  return arr;
}


