import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/src/image/image_data.dart';
import 'package:image_picker/image_picker.dart';
import 'grafik.dart';
import 'image_processor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> _images = [];

  Future _getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _images.add(File(pickedImage.path)); // Seçilen fotoğrafı listeye ekle
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
        _images.add(File(pickedImage.path)); // Seçilen fotoğrafı listeye ekle
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pİxel Calculate'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _getImageFromCamera,
                    child: Text('Take Photo'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _getImageFromGallery,
                    child: Text('Select Photo'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0), // Dikeyde 2 birim boşluk
                    child: AspectRatio(
                      aspectRatio: 16 / 9, // Oranı istediğiniz gibi ayarlayabilirsiniz
                      child: Image.file(
                        _images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // İkinci ekrana geçiş yapmadan önce pikselleri al
                  ImageData? pixels = ImageProcessor.getPixelsFromFile(_images[0]);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(pixels as Uint8List),
                    ),
                  );
                },
                child: Text('Calculate'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
