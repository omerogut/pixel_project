import 'dart:io';
import 'package:image/image.dart' as img; // image paketini eklemelisiniz

class ImageProcessor {
  static img.ImageData? getPixelsFromFile(File file) {
    final image = img.decodeImage(file.readAsBytesSync());
    return image!.data;
  }
}
