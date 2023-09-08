import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'redfile.dart';



class HomeScreen extends StatefulWidget  {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> _images = [];

  int? get redPixelCount => null;// Seçilen veya çekilen fotoğrafları saklamak için bir liste

  int calculateRedPixelIntensity(Image image) {
    int redPixelCount = 0;

    for (int y = 0; y < image.height!.toInt(); y++) {
      for (int x = 0; x < image.width!.toInt(); x++) {
        Color pixel = image.getPixel(x, y);

        if (pixel.red >= 200 && pixel.green <= 100 && pixel.blue <= 100) {
          redPixelCount++;
        }
      }
    }

    return redPixelCount;
  }

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

                      // Sonuç sayfasına geçiş yap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(redPixelCount!),
                        ),
                      );

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

                      // Sonuç sayfasına geçiş yap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(redPixelCount!),
                        ),
                      );

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
              onPressed: () async {
                // Hesapla butonuna basıldığında sonucu göstermek için yeni sayfaya geçiş yap
                if (_images.isNotEmpty) {
                  File lastImage = _images.last;
                  Image img = decodeImage(Uint8List.fromList(lastImage.readAsBytesSync()));
                  int redPixelCount = calculateRedPixelIntensity(img);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(redPixelCount),
                    ),
                  );
                }
              },
              child: Text('Hesapla'),
            ),
          ],
        ),
      ),
    );
  }
}
