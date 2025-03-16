import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Row(
          children: <Widget>[
            Container(color: Colors.tealAccent, width: 100, height: 100),
            Container(color: Colors.pinkAccent, width: 100, height: 100),
          ],
        ),
      ),
    ),
  );
}
