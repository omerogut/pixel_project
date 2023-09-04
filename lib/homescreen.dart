import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'grafik.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  Future _getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotoğraf Seçme ve Gösterme'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _getImageFromCamera,
                  child: Text('Kameradan Fotoğraf Çek'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _getImageFromGallery,
                  child: Text('Galeriden Fotoğraf Seç'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: _image != null
                  ? Image.file(
                _image!,
                fit: BoxFit.cover,
              )
                  : Text('Fotoğraf Henüz Seçilmedi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()), // İkinci ekranı aç
                );
              },
              child: Text('Hesapla'),
            ),
          ],
        ),
      ),
    );
  }
}