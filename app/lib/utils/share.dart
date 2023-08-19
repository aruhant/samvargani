import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

shareScreenShot(ScreenshotController screenshotController, String message) {
  screenshotController
      .capture(delay: const Duration(milliseconds: 200))
      .then((image) async {
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);
      await Share.shareXFiles([XFile(imagePath.path)], text: message);
    }
  });
}

shareImage(Uint8List image, String message) async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = await File('${directory.path}/image.png').create();
  await imagePath.writeAsBytes(image);
  await Share.shareXFiles([XFile(imagePath.path)], text: message);
}
