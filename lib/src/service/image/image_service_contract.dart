import 'dart:io';

abstract class ImageServiceContract {
  Future<File?>? pickImage();
}
