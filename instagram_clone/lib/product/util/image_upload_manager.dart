import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUploadManager {
  Future<File> uploadImage(String inputSource) async {
    final picker = ImagePicker();
    final XFile? pickerImage = await picker.pickImage(
        source:
            inputSource == "camera" ? ImageSource.camera : ImageSource.gallery);

    File imageFile = File(pickerImage!.path);
    return imageFile;
  }

  Future<List<XFile>> uploadImages() async {
    final picker = ImagePicker();

    List<XFile>? pickedFiles = await picker.pickMultiImage();

    return pickedFiles;
  }
}
