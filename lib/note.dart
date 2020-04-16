import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'textInnput.dart';
import 'home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Note extends StatefulWidget {

  String message;
  String status;
  String name;
  Note({this.name,this.status, this.message,});

  Note.empty({this.name}) {
    status = 'false';
    message='';
  }

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {

  final _firestore= Firestore.instance;

  TextInput ti=TextInput(initial:'',);
  @override
  Widget build(BuildContext context) {
    IconData mark= widget.status== 'false'? Icons.info:Icons.check;
//    widget.name= _firestore.collection('notes').document().documentID;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 20,10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(mark,color: mark==Icons.check? Colors.green:Colors.red,),
            onPressed: ()async{
                widget.status= widget.status == 'false' ? 'true' : 'false';
                await _firestore.collection('notes').document(widget.name).setData(
                    {'message':widget.message,
                      'status':widget.status,
                    }
                );
                setState(() {
                });
            },
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow[200],
              ),
              height: 60,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.message, style: TextStyle(color: Colors.black),textAlign: TextAlign.justify,),
              ),
            ),
            onTap: (){
              Alert(
                context: context,
                type: AlertType.info,
                title: "Type yout text here",
                content: ti,
                style: AlertStyle(
                  backgroundColor: Colors.white,
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "Enter",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onPressed: ()async{
                      Navigator.pop(context);
                      widget.message=ti.getText();
                      await _firestore.collection('notes').document(widget.name).setData(
                        {'message':widget.message,
                          'status':widget.status,
                        }
                        );
                      setState(() {
                      });
                    },
                    width: 120,
                  ),
                  DialogButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  ),
                ],
              ).show();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete,color: Colors.red,),
            onPressed: (){
              try {
                _firestore.collection('notes').document(
                    widget.name).delete();
                widget.message='This task is no more available';
                setState(() {

                });
              }
              catch(e)
              {
                print(e);
              }
//              notes.removeAt(widget.number);
//              notes.insert(widget.number, SizedBox());

            },
          ),
        ],
      ),
    );
  }
}