import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget{
  final controller;
  final double height;
  final onChange;
  final  VoidCallback onTap;
  final VoidCallback suffixIconOnTab;
  final FocusNode focusNode;
  SearchBar({Key key, this.height,this.onChange,this.controller,this.focusNode,this.onTap, this.suffixIconOnTab}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
          width: 250,
          height: 36,
          // padding: EdgeInsets.all(24),
          child : TextField(
            onTap: onTap,
            textAlignVertical: TextAlignVertical.bottom,
            style: TextStyle(
                fontSize: 16,
                fontFamily: "NotoSans",
                color: Color.fromRGBO(102, 102, 102, 1.0)
            ),
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: "NotoSans",
                    color: Color.fromRGBO(102, 102, 102, 1.0)
                ),

                hintText: '검색하세요.',
                prefixIcon: IconButton(icon: Icon(Icons.search)),
                suffixIcon: GestureDetector(
                    onTap: suffixIconOnTab,
                    child: IconButton(icon: Icon(Icons.clear))
                ),
                filled: true,
                fillColor: Color.fromRGBO(142, 142, 147, 0.24),
                border: OutlineInputBorder(
                    borderSide:BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0))

            ),
            controller: controller,
            onChanged: onChange,
          )
      );
  }
}