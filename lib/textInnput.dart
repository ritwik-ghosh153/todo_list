import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {

  String initial;
  static String ini='';
  TextInput({this.initial}){
    ini=initial;
  }

  final TextEditingController _myController = TextEditingController()..text=ini ?? '';


  String getText() {///getter method for text
    return _myController.text;
  }

  TextEditingController getController() {///getter method for text controller
    return _myController;
  }


  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40,0,40,20),
        child: TextField(
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.yellow[200],
          ),
          controller: widget._myController,
        ),
      ),
    );
  }

}