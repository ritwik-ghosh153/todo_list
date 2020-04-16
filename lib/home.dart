import 'package:flutter/material.dart';
import 'note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<Widget> notes=[];
//int no=0;
class _HomeState extends State<Home> {
  final _firestore= Firestore.instance;

  void getNotes()async{
    final docs= await _firestore.collection('notes').getDocuments();
    for (var doc in docs.documents){
      notes.add(Note(name: doc.documentID,status: doc.data['status'].toString(),message: doc.data['message'],));
    print(doc.documentID);
    }
    setState(() {

    });
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('TO-DO LIST 📝',
        style: TextStyle(fontWeight: FontWeight.w800,fontSize: 25,fontFamily: 'Pacifico',),),
//        leading: Icon(Icons.library_books),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()async{
              String val=await _firestore.collection('notes').document().documentID;
              notes.add(Note.empty(name: val,));
              setState(() {});
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Column(
              children:notes,
            ),
          ],
        ),
      ),
    );
  }
}
