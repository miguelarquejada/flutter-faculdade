import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Example title')
      ),
      // body is the majority of the screen.
      body: Center(
        child: Text('Hello, world!'),
      )
    )
  ));
}