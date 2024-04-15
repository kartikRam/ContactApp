/*
* GetImages class is used to perform
* images related operations in the app
* */

import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class GetImages{
  Future<File?> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }
  Future<File?> captureImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      //print('No image captured.');
      return null;
    }
  }
  Future<Uint8List?> fileToUint8List(File file) async {
    try {
      // Read the file as bytes
      List<int> bytes = await file.readAsBytes();
      // Convert bytes to Uint8List
      Uint8List uint8list = Uint8List.fromList(bytes);
      return uint8list;
    } catch (e) {
      //print("Error converting file to Uint8List: $e");
      return null;
    }
  }
  Future<File?> uint8ListToFile(Uint8List? uint8list) async {
    if (uint8list == null) {
      print("Error: Uint8List is null.");
      return null;
    }
    try {
      // Get the temporary directory
      Directory tempDir = await getTemporaryDirectory();
      // Create a file within the temporary directory
      String filePath = '${tempDir.path}/temp_file_${DateTime.now().millisecondsSinceEpoch}.dat';
      File file = File(filePath);
      // Write the bytes of the Uint8List to the file
      await file.writeAsBytes(uint8list);
      return file;
    } catch (e) {
      print("Error converting Uint8List to file: $e");
      return null;
    }
  }


}