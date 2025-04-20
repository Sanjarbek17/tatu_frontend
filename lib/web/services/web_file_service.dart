import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'dart:html' as webFile;

class WebFileService {
  // Method to pick and read a file
  Future<Uint8List?> pickAndReadFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null || result.files.isEmpty)
        return null; // User canceled the picker

      final fileBytes = result.files.first.bytes;
      if (fileBytes == null) return null;

      return fileBytes;
    } catch (e) {
      print('Error reading file: $e');
      return null;
    }
  }

  // Method to download a file
  void downloadFile(String data, String fileName) {
    try {
      final blob = webFile.Blob([data], 'text/plain');

      final anchorElement =
          webFile.AnchorElement(href: webFile.Url.createObjectUrlFromBlob(blob))
            ..setAttribute("download", fileName)
            ..click();

      // Revoke the object URL to free up memory
      webFile.Url.revokeObjectUrl(anchorElement.href!);
    } catch (e) {
      print('Error downloading file: $e');
    }
  }
}
