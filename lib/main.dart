import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(Note());


class Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Home(),
      theme: ThemeData.dark(),
    );
  }
}
