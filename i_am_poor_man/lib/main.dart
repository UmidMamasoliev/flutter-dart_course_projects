import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Center(child: Text('Poor Man')),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Image(
            image: AssetImage('images/simpsons_png.png'),
          ),
        ),
      ),
    ),
  );
}
