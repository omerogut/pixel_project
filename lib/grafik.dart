import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Ekran'),
      ),
      body: Center(
        child: Text(
          'Bu ikinci bir ekran.',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}






