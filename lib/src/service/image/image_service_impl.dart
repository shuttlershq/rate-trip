import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'image_service_contract.dart';

class ImageService implements ImageServiceContract {
  @override
  Future<File?>? pickImage() async {
    final ImagePicker _picker = ImagePicker();
    File? file;
    final XFile? result = await _picker.pickImage(source: ImageSource.camera);

    if (result != null) {
      file = File(result.path);
    }
    return file;
  }
}
