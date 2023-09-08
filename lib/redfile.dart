import 'package:flutter/material.dart';


class ResultScreen extends StatelessWidget {
  final int redPixelCount;

  ResultScreen(this.redPixelCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kırmızı Piksel Yoğunluğu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kırmızı Piksel Yoğunluğu:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$redPixelCount',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
