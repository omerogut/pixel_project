import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'grafik.dart';
import 'package:gallery_saver/gallery_saver.dart';

class HomeScreen extends StatefulWidget  {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> _images = [];// Seçilen veya çekilen fotoğrafları saklamak için bir liste

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Fotoğraf çekme işlemi
                ElevatedButton(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(source: ImageSource.camera);
                    if (image != null) {
                      File photo = File(image.path);
                      // Fotoğrafı galeriye kaydetme işlemi
                       GallerySaver.saveImage(photo.path);

                      setState(() {
                        _images.add(photo);
                      });
                    }
                  },
                  child: Text('Fotoğraf Çek'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      File photo = File(image.path);
                      setState(() {
                        _images.add(photo);
                      });
                    }
                  },
                  child: Text('Fotoğraf Seç'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(2.0), // 2 birim boşluk ekleyin
                    child: Image.file(
                      _images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Hesapla butonuna basıldığında SecondScreen'e geçiş yap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(),
                  ),
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
