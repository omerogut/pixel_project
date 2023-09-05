import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart';

class SecondScreen extends StatelessWidget {
  final dynamic pixels; // dynamic tür kullanarak hem ImageDataUint8 hem de Uint8List kabul edebilirsiniz.

  SecondScreen(this.pixels);

  @override
  Widget build(BuildContext context) {
    if (pixels is Image) {
      var img;
      final Uint8List uint8Pixels = img.encodePng(pixels); // Örnek bir işlem
      return _buildScreen(uint8Pixels);
    } else if (pixels is Uint8List) {
      return _buildScreen(pixels);
    } else {
      return Center(
        child: Text('Invalid pixel data'),
      );
    }

  }

  Widget _buildScreen(Uint8List uint8Pixels) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.memory(uint8Pixels), // Pikselleri görüntülemek için Image.memory kullanın
          ],
        ),
      ),
    );
  }
}
